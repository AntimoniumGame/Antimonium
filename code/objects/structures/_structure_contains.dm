/obj/structure
	var/list/contains
	var/max_contains_count =       0
	var/max_contains_size_single = 0
	var/max_contains_size_total =  0
	var/open = FALSE
	var/can_open = FALSE

/obj/structure/MouseDrop(over_object,src_location,over_location,src_control,over_control,params)
	var/mob/user = over_object
	if(usr != user || !IsAdjacentTo(src, user))
		return
	var/list/arguments = params2list(params)
	DraggedOnto(user, arguments["left"], arguments["right"], arguments["middle"])

/obj/structure/proc/DraggedOnto(var/mob/user, var/left_drag, var/right_drag, var/middle_drag)
	var/slot = user.GetSlotByHandedness(left_drag ? "left" : "right")
	if(!slot)
		return
	if(contains)
		if(contains.len)
			var/obj/item/thing = pick(contains)
			contains -= thing
			thing.ForceMove(get_turf(src))
			if(user.CollectItem(thing, slot))
				user.NotifyNearby("\The [user] rummages around in \the [src] and pulls out \a [thing].")
			else
				contains += thing
				thing.ForceMove(src)
		else
			user.NotifyNearby("\The [user] rummages around in \the [src] but comes up empty handed.")

/obj/structure/Initialize()
	if(max_contains_count > 0 && max_contains_size_single > 0 && max_contains_size_total > 0)
		contains = list()
		can_open = TRUE
	. = ..()

/obj/structure/ManipulatedBy(var/mob/user, var/slot)
	. = ..()
	if(!. && ToggleOpen(user, slot))
		return TRUE
	return FALSE

/obj/structure/proc/ToggleOpen(var/mob/user, var/slot)
	if(!can_open)
		return FALSE
	if(Burn(user, SLOT_HANDS))
		user.Notify("\The [src] is far too hot to touch!")
		return FALSE
	open = !open
	if(user) user.NotifyNearby("\The [user] [open ? "opens" : "closes"] \the [src].")
	UpdateIcon()
	return TRUE

/obj/structure/proc/CanAcceptItem(var/obj/item/prop)
	if(!open)
		return FALSE
	if(contains && contains.len == max_contains_count)
		return FALSE
	if(prop.GetAmount() > max_contains_size_single)
		return FALSE
	var/total_size = 0
	for(var/thing in contains)
		var/atom/atom = thing
		if(istype(atom))
			total_size += atom.GetAmount()
	if(total_size + prop.GetAmount() > max_contains_size_total)
		return FALSE
	return TRUE

/obj/structure/AttackedBy(var/mob/user, var/obj/item/prop)
	. = ..()
	if(!.)
		if(contains) // will be null in non-containers, todo: better check
			if(!open)
				user.Notify("\The [src] is closed.")
				return TRUE
			if(!CanAcceptItem(prop))
				user.Notify("\The [prop] will not fit into \the [src].")
				return TRUE
			if(user.DropItem(prop))
				if(prop && !Deleted(prop))
					prop.ForceMove(src)
					contains += prop
					user.NotifyNearby("\The [user] places \the [prop] into \the [src].")
					return TRUE
	return FALSE
