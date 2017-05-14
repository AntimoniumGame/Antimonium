/mob
	var/list/inventory_slots = list()

/mob/proc/drop_item(var/obj/item/thing)
	thing.before_dropped()
	thing.force_move(get_turf(src))
	thing.after_dropped()
	for(var/invslot in inventory_slots)
		var/obj/ui/inv/inv_slot = inventory_slots[invslot]
		if(inv_slot.holding == thing)
			inv_slot.forget_held()
			break
	update_icon()
	return TRUE

/mob/proc/collect_item(var/obj/item/thing, var/equip_to_slot)
	if(!equip_to_slot)
		return FALSE
	var/obj/ui/inv/equipping = inventory_slots[equip_to_slot]
	if(equipping.holding)
		return FALSE
	thing.before_picked_up()
	thing.force_move(src)
	thing.after_picked_up()
	equipping.set_held(thing)
	update_icon()
	return TRUE

/mob/proc/collect_item_or_del(var/obj/item/thing, var/equip_to_slot)
	if(!collect_item(thing, equip_to_slot))
		qdel(thing)

/mob/proc/get_equipped(var/slot_id)
	var/obj/ui/inv/inv_slot = inventory_slots[slot_id]
	if(inv_slot)
		return inv_slot.holding

/mob/proc/update_inventory()
	for(var/slot_id in inventory_slots)
		var/obj/ui/inv/slot = inventory_slots[slot_id]
		slot.update_icon()
		slot.update_strings()
