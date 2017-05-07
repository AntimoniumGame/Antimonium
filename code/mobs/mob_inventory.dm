/mob/proc/drop_item(var/obj/item/thing)
	thing.move_to(get_turf(src))
	return TRUE

/mob/proc/collect_item(var/obj/item/thing)
	var/mob/holder = thing.loc
	if(istype(holder))
		holder.drop_item(thing)
	thing.move_to(src)
	return TRUE
