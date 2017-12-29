/obj
	var/precise_reagent_transfer
	var/current_reagent_volume = 0
	var/max_reagent_volume
	var/list/contains_reagents

/obj/Destroy()
	if(contains_reagents)
		for(var/thing in contains_reagents)
			var/obj/prop = thing
			prop.ForceMove(get_turf(src))
		contains_reagents.Cut()
	. = ..()

/obj/New()
	..()
	if(max_reagent_volume)
		contains_reagents = list()

/obj/proc/CanAcceptReagentObject(var/obj/item/prop, var/mob/user)
	if(!contains_reagents)
		return FALSE
	if(!istype(prop, /obj/item/stack/reagent) || !prop.material)
		if(user) user.Notify("<span class='warning'>\The [src] is not an appropriate container for \the [prop].</span>")
		return FALSE
	if(current_reagent_volume + prop.GetAmount() > max_reagent_volume)
		if(user) user.Notify("<span class='warning'>\The [src] does not have enough room for \the [prop].</span>")
		return FALSE
	return TRUE

/obj/proc/PutReagentInside(var/obj/item/prop, var/mob/user)
	if(user)
		user.NotifyNearby("<span class='notice'>\The [user] places \the [prop] into \the [src].</span>", MESSAGE_VISIBLE)
		user.DropItem(prop)
	prop.ForceMove(src)
	contains_reagents += prop
	MergeReagents()
	UpdateIcon()

/obj/proc/IsReagentContainer()
	return (contains_reagents && max_reagent_volume > 0)

/obj/proc/RemoveReagent(var/obj/item/prop)
	contains_reagents -= prop
	UpdateReagentVolume()

/obj/proc/HasRoomForReagents(var/amount=1)
	return ((max_reagent_volume-current_reagent_volume)>=amount)

/obj/proc/TransferReagentsFrom(var/obj/item/prop, var/mob/user)

	if(!prop.contains_reagents.len)
		return FALSE

	var/transferred_amount = 0
	var/transfer_per_reagent = max(1,round((max_reagent_volume-current_reagent_volume)/prop.contains_reagents.len))

	for(var/thing in prop.contains_reagents)

		var/obj/item/stack/reagent/reagent = thing
		var/partial_transfer

		if(!HasRoomForReagents(transfer_per_reagent))
			break

		var/obj/item/stack/reagent/removed
		if(reagent.GetAmount() <= transfer_per_reagent)
			removed = reagent
		else
			removed = new /obj/item/stack/reagent(null, reagent.material.type, transfer_per_reagent, reagent)
			partial_transfer = TRUE

		if(!CanAcceptReagentObject(removed))
			QDel(removed, "unacceptable reagent")
			break

		var/amount_removed = removed.GetAmount()
		if(!partial_transfer)
			prop.RemoveReagent(removed)
		else
			reagent.Remove(amount_removed)
		transferred_amount += amount_removed
		PutReagentInside(removed)

	if(transferred_amount > 0)
		MergeReagents()
		prop.UpdateReagentVolume()
		prop.UpdateIcon()
		UpdateIcon()

		prop.UpdateIcon()
		UpdateIcon()
		if(user)
			if(precise_reagent_transfer)
				user.Notify("<span class = 'notice'>You decant [transferred_amount] unit\s from \the [prop] into \the [src].</span>")
			else
				user.Notify("<span class = 'notice'>You decant [prop.current_reagent_volume <= 0 ? "the last of" : "some of"] \the [prop] into \the [src].</span>")
			user.UpdateIcon()
		return TRUE
	return FALSE

/obj/AttackedBy(var/mob/user, var/obj/item/prop)
	. = ..()
	if(!. && IsReagentContainer())
		if(prop.IsReagentContainer())
			if(TransferReagentsFrom(prop, user))
				return TRUE
			if(prop.TransferReagentsFrom(src, user))
				return TRUE
		if(CanAcceptReagentObject(prop, user) && PutReagentInside(prop, user))
			return TRUE

/obj/proc/MergeReagents()
	for(var/thing in contains_reagents)
		if(!thing || Deleted(thing))
			continue
		var/obj/item/stack/reagent/reagent = thing
		reagent.MergeWithOtherStacks(contains_reagents)

	UpdateReagentVolume()
	ProcessReagentReactions(src, contains_reagents)

/obj/proc/UpdateReagentVolume()
	current_reagent_volume = 0
	for(var/thing in contains_reagents)
		if(!thing || Deleted(thing))
			continue
		var/obj/item/stack/reagent/reagent = thing
		current_reagent_volume += reagent.GetAmount()

/obj/DraggedOntoThing(var/mob/user, var/atom/thing, var/left_drag, var/right_drag, var/middle_drag)
	. = ..()
	if(!. && IsReagentContainer())
		if(istype(thing, /obj/ui/inv))
			var/obj/ui/inv/prop = thing
			if(prop.holding && prop.holding.IsReagentContainer())
				return prop.holding.TransferReagentsFrom(src, user)
		if(istype(thing, /obj))
			var/obj/prop = thing
			if(istype(prop) && prop.IsReagentContainer())
				return prop.TransferReagentsFrom(src, user)
