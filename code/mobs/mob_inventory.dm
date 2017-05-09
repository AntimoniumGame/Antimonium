/mob
	var/list/inventory_slots = list()

/mob/proc/drop_item(var/obj/item/thing)
	thing.before_dropped()
	thing.move_to(get_turf(src))
	thing.after_dropped()
	return TRUE

/mob/proc/collect_item(var/obj/item/thing)
	thing.before_picked_up()
	thing.move_to(src)
	thing.after_picked_up()
	return TRUE

/mob/proc/get_equipped(var/slot_id)
	return
