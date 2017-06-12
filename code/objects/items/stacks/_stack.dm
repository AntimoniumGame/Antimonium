/obj/item/stack
	sharpness = 0
	contact_size = 1

	var/amount = 20
	var/max_amount = 20
	var/singular_name = "thing"
	var/plural_name =   "things"
	var/stack_name =    "stack"
	var/can_craft_with = FALSE

	var/list/stack_overlays		// a list of all the image overlays for this stack

/obj/item/stack/ForceMove()
	. = ..()
	MergeWithLocalStacks()

/obj/item/stack/proc/MergeWithLocalStacks()

	if(!istype(loc, /turf))
		return

	for(var/obj/item/stack/stack in loc)
		if(src && stack != src && !Deleted(src) && GetAmount() >= 1)
			if(!MatchesStackType(stack))
				continue
			var/transfer_amount = max_amount - GetAmount()
			if(transfer_amount <= 0)
				continue
			else if(stack.GetAmount() <= transfer_amount)
				stack.Add(GetAmount())
				QDel(src)
			else
				transfer_amount = stack.max_amount - stack.GetAmount()
				stack.Add(transfer_amount)
				Remove(transfer_amount)

/obj/item/stack/DraggedOntoThing(var/mob/user, var/atom/thing, var/left_drag, var/right_drag, var/middle_drag)

	if(GetAmount() <= 1)
		user.Notify("<span class='warning'>There are not enough [plural_name] in the [stack_name] to split it.</span>")
		return

	var/split_amount = max(1,round(GetAmount()/2))
	Remove(split_amount)
	new type(get_turf(thing), material ? material.type : default_material_path, split_amount, src)
	user.NotifyNearby("<span class='notice'>\The [user] splits the [plural_name] into two roughly equal [stack_name]s.</span>")

/obj/item/stack/GetWeight()
	return GetAmount() * weight

/obj/item/stack/New(var/newloc, var/material_path, var/_amount)
	if(_amount && _amount > 0)
		amount = min(max_amount, max(1, _amount))
	else
		amount = max_amount
	..(newloc, material_path)
	MergeWithLocalStacks()

/obj/item/stack/Use(var/mob/user)

	if(GetAmount() <= 1)
		user.Notify("<span class='warning'>There are not enough [plural_name] in the [stack_name] to split it.</span>")
		return

	var/split_amount = input("How many would you like to remove?") as null|num
	if(!split_amount || split_amount < 1 || split_amount >= max_amount)
		return

	Remove(split_amount)
	new type(get_turf(user), material ? material.type : default_material_path, split_amount, src)
	user.NotifyNearby("<span class='notice'>\The [user] splits the [plural_name] into two [stack_name]s.</span>")

/obj/item/stack/proc/MatchesStackType(var/obj/item/stack/stack)
	return (istype(stack) && type == stack.type && material == stack.material)

/obj/item/stack/AttackedBy(var/mob/user, var/obj/item/prop)

	if(can_craft_with && (prop.associated_skill & SKILL_CONSTRUCTION))
		var/list/structs = material.GetBuildableStructures(src)
		if(structs.len)
			if(locate(/obj/structure) in loc)
				user.Notify("<span class='warning'>There is already a structure in this location.</span>")
			else
				if(GetAmount() < material.GetStructureCost())
					user.Notify("<span class='warning'>There is not enough in \the [src] to build that.</span>")
				else
					var/select_type = input("Select a structure type.") as null|anything in structs
					if(select_type)
						var/atom/thing = new select_type(get_turf(src), material_path = material.type)
						user.NotifyNearby("<span class='notice'>\The [user] builds \a [thing].</span>")
						Remove(material.GetStructureCost())
		return TRUE

	if(prop.associated_skill & SKILL_ALCHEMY)
		if(GetAmount() > 5)
			user.Notify("<span class='warning'>There are too many [plural_name] in this [stack_name] to grind with \the [prop].</span>")
		else
			Grind(user)
		return TRUE

	if(material && can_craft_with)
		if(TryCraft(user, prop) || TryBuild(user, prop))
			return TRUE

	if(MatchesStackType(prop))
		var/obj/item/stack/other = prop
		var/transfer_amount = max_amount - GetAmount()
		if(transfer_amount <= 0)
			user.Notify("<span class='warning'>That [stack_name] can hold no more [plural_name].</span>")
			return TRUE
		else if(other.GetAmount() <= transfer_amount)
			other.Add(GetAmount())
			user.NotifyNearby("<span class='notice'>\The [user] merges two [stack_name]s of [plural_name] together.</span>")
			QDel(src)
		else
			transfer_amount = other.max_amount - other.GetAmount()
			other.Add(transfer_amount)
			Remove(transfer_amount)
			user.NotifyNearby("<span class='notice'>\The [user] transfers some [plural_name] between two [stack_name]s.</span>")
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

/obj/item/stack/GetRadialMenuContents(var/mob/user, var/menu_type, var/args)
	if(menu_type == RADIAL_MENU_CRAFTING && istype(args, /obj/item) && material)
		var/obj/item/prop = args
		return material.GetRecipesFor(prop.associated_skill, get_turf(src), src)
	return ..()

/obj/item/stack/proc/TryCraft(var/mob/user, var/obj/item/prop)
	var/list/options = GetRadialMenuContents(user, RADIAL_MENU_CRAFTING, prop)
	if(options && options.len)
		new /obj/ui/radial_menu/crafting(user, src, prop)
		return TRUE
	return FALSE

/obj/item/stack/proc/TryBuild(var/mob/user, var/obj/item/prop)
/*
	if(prop.associated_skill & SKILL_ARCHITECTURE)
		var/list/buildings = material.GetBuildableTurfs(src)
		if(buildings.len)
			if(GetAmount() < material.GetTurfCost())
				user.Notify("<span class='warning'>There is not enough in \the [src] to build that.</span>")
			else
				if(locate(/obj/structure/foundation) in get_turf(src))
					user.Notify("<span class='warning'>There is already a foundation in that location.</span>")
					return TRUE
				if(locate(/obj/structure) in get_turf(src))
					user.Notify("<span class='warning'>There is a structure occupying that location.</span>")
					return TRUE
				var/select_type = input("Select a building type.") as null|anything in buildings
				if(select_type)
					user.NotifyNearby("<span class='notice'>\The [user] lays out a foundation.</span>")
					new /obj/structure/foundation(get_turf(src), material.type, select_type, new type(null, material.type, material.GetTurfCost()))
					Remove(material.GetTurfCost())
			return TRUE
*/