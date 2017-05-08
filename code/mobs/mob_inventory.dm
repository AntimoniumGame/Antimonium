/mob
	var/list/inventory_slots = list()

/mob/proc/drop_item(var/obj/item/thing)
	thing.move_to(get_turf(src))
	return TRUE

/mob/proc/collect_item(var/obj/item/thing)
	if(thing.loc == src)
		return TRUE
	if(!is_adjacent_to(get_turf(src), get_turf(thing)))
		notify("\The [thing] is too far away.")
		return FALSE
	var/mob/holder = thing.loc
	if(istype(holder))
		holder.drop_item(thing)
	notify_nearby("\The [src] picks up \the [thing].")
	thing.move_to(src)
	return TRUE

/mob/proc/get_equipped(var/slot_id)
	return
