/mob/human
	var/list/inventory_slots = list()

/mob/human/collect_item(var/obj/item/thing, var/equip_to_slot)
	if(!equip_to_slot)
		return FALSE
	. = ..()
	if(.)
		var/obj/ui/inv/equipping = inventory_slots[equip_to_slot]
		if(equipping.holding)
			drop_item(thing)
			return FALSE
		equipping.set_held(thing)
		update_icon()

/mob/human/drop_item(var/obj/item/thing)
	. = ..()
	if(.)
		for(var/invslot in inventory_slots)
			var/obj/ui/inv/inv_slot = inventory_slots[invslot]
			if(inv_slot.holding == thing)
				inv_slot.forget_held()
				break
		update_icon()

/mob/human/get_equipped(var/slot_id)
	var/obj/ui/inv/inv_slot = inventory_slots[slot_id]
	if(inv_slot)
		return inv_slot.holding
