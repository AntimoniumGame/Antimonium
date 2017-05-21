/obj/item/stack
	name = "coins"
	sharpness = 0
	contact_size = 1
	default_material_path = /datum/material/metal/gold
	icon = 'icons/objects/items/coin.dmi'

	var/amount = 20
	var/max_amount = 20
	var/singular_name = "coin"
	var/plural_name =   "coins"
	var/stack_name =    "stack"

/obj/item/stack/GetWeight()
	return GetAmount() * (material ? material.weight_modifier : 1)

/obj/item/stack/New(var/newloc, var/material_path, var/_amount)
	if(_amount && _amount > 0)
		amount = min(max_amount, max(1, _amount))
	else
		amount = max_amount
	..(newloc, material_path)

/obj/item/stack/Use(var/mob/user)
	if(GetAmount() <= 1)
		user.Notify("There are not enough [plural_name] in the [stack_name] to split it.")
		return

	var/split_amount = max(1,round(GetAmount()/2))
	Remove(split_amount)
	new type(get_turf(user), material.type, split_amount, src)
	user.NotifyNearby("\The [user] splits the [plural_name] into two roughly equal [stack_name]s.")

/obj/item/stack/proc/MatchesStackType(var/obj/item/stack/stack)
	return (istype(stack) && type == stack.type && material == stack.material)

/obj/item/stack/AttackedBy(var/mob/user, var/obj/item/prop)
	if(MatchesStackType(prop))
		var/obj/item/stack/other = prop
		var/transfer_amount = max_amount - GetAmount()
		if(transfer_amount <= 0)
			user.Notify("That [stack_name] can hold no more [plural_name].")
			return TRUE
		else if(other.GetAmount() <= transfer_amount)
			other.Add(GetAmount())
			user.NotifyNearby("\The [user] merges two [stack_name]s of [plural_name] together.")
			QDel(src)
		else
			transfer_amount = other.max_amount - other.GetAmount()
			other.Add(transfer_amount)
			Remove(transfer_amount)
			user.NotifyNearby("\The [user] transfers some [plural_name] between two [stack_name]s.")
		return TRUE
	else
		. = ..()

/obj/item/stack/UpdateStrings()
	if(amount > 1)
		if(material)
			name = "[stack_name] of [amount] [material.GetDescriptor()] [plural_name]"
		else
			name = "[stack_name] of [amount] [plural_name]"
	else
		if(material)
			name = "[material.GetDescriptor()] [singular_name]"
		else
			name = "[singular_name]"

/obj/item/stack/UpdateIcon(var/list/supplied = list())
	for(var/stack_amount = min(10, amount), stack_amount > 1, stack_amount--)
		var/image/I = image(icon = icon, icon_state = "world")
		I.pixel_x = rand(-5,5)
		I.pixel_y = rand(-5,5)
		supplied += I
	shadow_size = min(3,max(1, round(amount/10)))
	..(supplied)

/obj/item/stack/GetAmount()
	return amount

/obj/item/stack/GetInvIcon()
	var/image/I = GetWornIcon("held")
	I.maptext = "<center>x<b>[GetAmount()]</b></center>"
	I.maptext_width = 32
	I.maptext_height = 32
	I.maptext_y = -12
	return I

/obj/item/stack/proc/Add(var/amt)
	amount = min(max_amount,amount+amt)
	UpdateIcon()
	UpdateStrings()

/obj/item/stack/proc/SetAmt(var/amt)
	amount = max(1, min(max_amount, amt))
	UpdateIcon()
	UpdateStrings()

/obj/item/stack/proc/Remove(var/amt)
	amount = max(0, amount-amt)
	if(amount <= 0)
		QDel(src)
	else
		UpdateIcon()
		UpdateStrings()

