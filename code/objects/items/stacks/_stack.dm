/obj/item/stack
	sharpness = 0
	contact_size = 1

	var/amount
	var/max_amount = 20
	var/singular_name = "thing"
	var/plural_name =   "things"
	var/stack_name =    "stack"
	var/can_craft_with = FALSE

	var/list/stack_overlays		// a list of all the image overlays for this stack

/obj/item/stack/ForceMove()
	. = ..()
	MergeWithOtherStacks()

/obj/item/stack/GetInHandAppearanceAtom()
	return image(icon, GetIndividualStackIcon())

/obj/item/stack/proc/MergeWithOtherStacks(var/list/merging_with)

	if(Deleted(src) || !loc || istype(loc, /mob)) // To avoid stacks held in the hands merging.
		return

	if(!merging_with)
		if(istype(loc, /obj/structure))
			var/obj/structure/holder = loc
			if(holder.contains)
				merging_with = holder.contains
		else if(istype(loc, /turf))
			var/turf/holder = loc
			merging_with = holder.contents

	if(!merging_with || !merging_with.len || !(src in merging_with))
		return

	for(var/obj/item/stack/stack in loc)
		if(Deleted(src))
			break
		if(src && stack != src && !Deleted(stack) && GetAmount() >= 1)
			if(!MatchesStackType(stack))
				continue
			var/transfer_amount = max_amount - GetAmount()
			if(transfer_amount <= 0)
				continue
			else if(stack.GetAmount() <= transfer_amount)
				transfer_amount = stack.GetAmount()
			Add(transfer_amount)
			stack.Remove(transfer_amount)

/obj/item/stack/DraggedOntoThing(var/mob/user, var/atom/thing, var/left_drag, var/right_drag, var/middle_drag)
	. = ..()
	if(!.)
		if(GetAmount() <= 1)
			user.Notify("<span class='warning'>There are not enough [plural_name] in the [stack_name] to split it.</span>")
		else
			var/split_amount = max(1,round(GetAmount()/2))
			Remove(split_amount)
			new type(get_turf(thing), material ? material.type : default_material_path, split_amount, src)
			user.NotifyNearby("<span class='notice'>\The [user] splits the [plural_name] into two roughly equal [stack_name]s.</span>", MESSAGE_VISIBLE)
		return TRUE

/obj/item/stack/GetWeight()
	return GetAmount() * weight

/obj/item/stack/New(var/newloc, var/material_path, var/_amount)
	if(_amount && _amount > 0)
		amount = _amount
	else if(isnull(amount))
		amount = max_amount
	..(newloc, material_path)
	MergeWithOtherStacks()

/obj/item/stack/Use(var/mob/user)
	. = ..()
	if(!.)
		if(GetAmount() <= 1)
			user.Notify("<span class='warning'>There are not enough [plural_name] in the [stack_name] to split it.</span>")
			return TRUE

		var/split_amount = input("How many would you like to remove?") as null|num
		if(!split_amount || split_amount < 1 || split_amount >= max_amount)
			return TRUE

		Remove(split_amount)
		var/obj/removed = new type(get_turf(user), material ? material.type : default_material_path, split_amount, src)
		user.NotifyNearby("<span class='notice'>\The [user] splits the [plural_name] into two [stack_name]s.</span>", MESSAGE_VISIBLE)
		user.TryPutInHands(removed)
		return TRUE

/obj/item/stack/proc/MatchesStackType(var/obj/item/stack/stack)
	return (istype(stack) && type == stack.type && material == stack.material)

/obj/item/stack/AttackedBy(var/mob/user, var/obj/item/prop)

	if(prop.associated_skill & SKILL_ALCHEMY)
		if(GetAmount() > 5)
			user.Notify("<span class='warning'>There are too many [plural_name] in this [stack_name] to grind with \the [prop].</span>")
		else
			Grind(user)
		return TRUE

	if(material)
		if(can_craft_with)
			if(TryCraft(user, prop))
				return TRUE
			if(TryBuildStruct(user, prop))
				return TRUE
		if(TryBuild(user, prop))
			return TRUE

	if(MatchesStackType(prop))
		var/obj/item/stack/other = prop
		var/transfer_amount = max_amount - GetAmount()
		if(transfer_amount <= 0)
			user.Notify("<span class='warning'>That [stack_name] can hold no more [plural_name].</span>")
			return TRUE
		else if(other.GetAmount() <= transfer_amount)
			other.Add(GetAmount())
			user.NotifyNearby("<span class='notice'>\The [user] merges two [stack_name]s of [plural_name] together.</span>", MESSAGE_VISIBLE)
			QDel(src, "stack merger")
		else
			transfer_amount = other.max_amount - other.GetAmount()
			other.Add(transfer_amount)
			Remove(transfer_amount)
			user.NotifyNearby("<span class='notice'>\The [user] transfers some [plural_name] between two [stack_name]s.</span>", MESSAGE_VISIBLE)
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

/obj/item/stack/proc/GetIndividualStackIcon()
	return "world"

/obj/item/stack/UpdateIcon()
	UpdateStackOverlays()
	..()

/obj/item/stack/proc/UpdateStackOverlays()
	var/list/overlays_list = overlays
	overlays_list -= stack_overlays

	stack_overlays = list()

	for(var/stack_amount = min(10, amount), stack_amount > 1, stack_amount--)
		var/image/I = image(icon = icon, icon_state = GetIndividualStackIcon())
		I.pixel_x = rand(-5,5)
		I.pixel_y = rand(-5,5)
		stack_overlays += I

	overlays_list += stack_overlays
	overlays = overlays_list

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

/obj/item/stack/proc/SetAmount(var/amt)
	amount = max(1, min(max_amount, amt))
	UpdateIcon()
	UpdateStrings()

/obj/item/stack/proc/Remove(var/amt)
	amount = max(0, amount-amt)
	if(amount <= 0)
		QDel(src, "emptied stack")
	else
		UpdateIcon()
		UpdateStrings()

/obj/item/stack/GetRadialMenuContents(var/mob/user, var/menu_type, var/args)
	if(material && istype(args, /obj/item))
		var/obj/item/prop = args
		if(menu_type == RADIAL_MENU_CRAFTING)
			return material.GetRecipesFor(prop.associated_skill, get_turf(src), src)
		if(menu_type == RADIAL_MENU_BUILDING && (prop.associated_skill & SKILL_ARCHITECTURE))
			return material.GetBuildableTurfs(src)
		if(menu_type == RADIAL_MENU_STRUCTURES && (prop.associated_skill & SKILL_CONSTRUCTION))
			return material.GetBuildableStructures(src)
	return ..()

/obj/item/stack/proc/TryCraft(var/mob/user, var/obj/item/prop)
	var/list/options = GetRadialMenuContents(user, RADIAL_MENU_CRAFTING, prop)
	if(options && options.len)
		new /obj/ui/radial_menu/prop/crafting(user, src, prop)
		return TRUE
	return FALSE

/obj/item/stack/proc/TryBuild(var/mob/user, var/obj/item/prop)
	var/list/options = GetRadialMenuContents(user, RADIAL_MENU_BUILDING, prop)
	if(options && options.len)
		new /obj/ui/radial_menu/prop/building(user, src, prop)
		return TRUE
	return FALSE

/obj/item/stack/proc/TryBuildStruct(var/mob/user, var/obj/item/prop)
	var/list/options = GetRadialMenuContents(user, RADIAL_MENU_STRUCTURES, prop)
	if(options && options.len)
		new /obj/ui/radial_menu/prop/structures(user, src, prop)
		return TRUE
	return FALSE
