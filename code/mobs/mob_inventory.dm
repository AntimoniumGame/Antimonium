/mob
	var/list/inventory_slots = list()

/mob/proc/drop_item(var/obj/item/thing)
	thing.before_dropped()
	thing.ForceMove(get_turf(src))
	thing.after_dropped()
	return TRUE

/mob/proc/collect_item(var/obj/item/thing, var/equip_to_slot)
	thing.before_picked_up()
	thing.ForceMove(src)
	thing.after_picked_up()
	return TRUE

/mob/proc/collect_item_or_del(var/obj/item/thing, var/equip_to_slot)
	if(!collect_item(thing, equip_to_slot))
		qdel(thing)

/mob/proc/get_equipped(var/slot_id)
	return

/mob/proc/equip_to_slot(var/obj/item/thing, var/slot_id)
	return !get_equipped(slot_id)
