/mob
	var/list/inventory_slots = list()

/mob/proc/DropItem(var/obj/item/thing)
	if(!istype(thing)) return FALSE
	thing.BeforeDropped()
	thing.ForceMove(get_turf(src))
	thing.AfterDropped()
	for(var/invslot in inventory_slots)
		var/obj/ui/inv/inv_slot = inventory_slots[invslot]
		if(inv_slot.holding == thing)
			inv_slot.ForgetHeld()
			break
	UpdateIcon()
	return TRUE

/mob/proc/DropSlot(var/invslot)
	var/obj/item/O = GetEquipped(invslot)
	if(istype(O))
		DropItem(O)

/mob/proc/CollectItem(var/obj/item/thing, var/equip_to_slot)
	if(!equip_to_slot)
		return FALSE
	var/obj/ui/inv/equipping = inventory_slots[equip_to_slot]
	if(!equipping || equipping.holding)
		return FALSE
	if(!thing.BeforePickedUp(src, equip_to_slot))
		return FALSE
	thing.ForceMove(src)
	thing.AfterPickedUp()
	equipping.SetHeld(thing)
	UpdateIcon()
	return TRUE

/mob/proc/CollectItemOrDel(var/obj/item/thing, var/equip_to_slot)
	if(!CollectItem(thing, equip_to_slot))
		QDel(thing)
		return FALSE
	return TRUE

/mob/proc/GetEquipped(var/slot_id)
	var/obj/ui/inv/inv_slot = inventory_slots[slot_id]
	if(inv_slot)
		return inv_slot.holding

/mob/proc/UpdateInventory()
	for(var/slot_id in inventory_slots)
		var/obj/ui/inv/slot = inventory_slots[slot_id]
		slot.UpdateIcon()
		slot.UpdateStrings()
		if(slot.update_bodyparts && slot.update_bodyparts.len)
			for(var/thing in slot.update_bodyparts)
				var/obj/item/limb/limb = limbs[thing]
				if(istype(limb))
					limb.SetHolding(slot.holding ? TRUE : FALSE)

/mob/proc/GetHeatInsulation(var/slot)
	return FALSE
