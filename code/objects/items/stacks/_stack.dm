/obj/item/stack
	name = "coins"
	sharpness = 0
	contact_size = 1
	default_material_path = /data/material/gold
	icon = 'icons/objects/items/coin.dmi'

	var/amount = 20
	var/max_amount = 20
	var/singular_name = "coin"
	var/plural_name = "coins"

/obj/item/stack/New(var/newloc, var/_amount)
	if(_amount && _amount > 0)
		amount = min(max_amount, max(1, _amount))
	else
		amount = max_amount
	..(newloc)

/obj/item/stack/use(var/mob/user)
	if(get_amount() <= 1)
		user.notify("There are not enough [plural_name] in the stack to split it.")
		return

	var/split_amount = max(1,round(get_amount()/2))
	remove(split_amount)
	new type(get_turf(user), split_amount)
	user.notify_nearby("\The [user] splits the [plural_name] into two roughly equal stacks.")

/obj/item/stack/proc/get_stack_type()
	return type //todo

/obj/item/stack/attacked_by(var/mob/user, var/obj/item/thing)
	var/obj/item/stack/other = thing
	if(istype(other) && other.get_stack_type() == get_stack_type())
		var/transfer_amount = max_amount - get_amount()
		if(transfer_amount <= 0)
			user.notify("That stack can hold no more [plural_name].")
			return TRUE
		else if(other.get_amount() <= transfer_amount)
			add(other.get_amount())
			qdel(other)
			user.notify_nearby("\The [user] merges two stacks of [plural_name] together.")
		else
			transfer_amount = max_amount - get_amount()
			add(transfer_amount)
			other.remove(transfer_amount)
			user.notify_nearby("\The [user] transfers some [plural_name] between two stacks.")
		return TRUE
	else
		. =..()

/obj/item/stack/update_strings()
	if(amount > 1)
		if(material)
			name = "stack of [amount] [material.get_descriptor()] [plural_name]"
		else
			name = "stack of [amount] [plural_name]"
	else
		if(material)
			name = "[material.get_descriptor()] [singular_name]"
		else
			name = "[singular_name]"

/obj/item/stack/update_icon()
	..()

	overlays.Cut()
	var/list/new_overlays = list()
	for(var/stack_amount = min(10, amount);stack_amount > 1;stack_amount--)
		var/image/I = image(icon = icon, icon_state = "world")
		I.pixel_x = rand(-5,5)
		I.pixel_y = rand(-5,5)
		new_overlays += I
	overlays = new_overlays

	var/mob/owner = loc
	if(istype(owner))
		owner.update_inventory()

/obj/item/stack/proc/get_amount()
	return amount

/obj/item/stack/get_inv_icon()
	var/image/I = get_worn_icon("held")
	I.maptext = "<center>x<b>[get_amount()]</b></center>"
	I.maptext_width = 32
	I.maptext_height = 32
	I.maptext_y = -12
	return I

/obj/item/stack/proc/add(var/amt)
	amount = min(max_amount,amount+amt)
	update_icon()
	update_strings()

/obj/item/stack/proc/set_amt(var/amt)
	amount = max(1, min(max_amount, amt))
	update_icon()
	update_strings()

/obj/item/stack/proc/remove(var/amt)
	amount = max(0, amount-amt)
	if(amount <= 0)
		qdel(src)
	else
		update_icon()
		update_strings()

