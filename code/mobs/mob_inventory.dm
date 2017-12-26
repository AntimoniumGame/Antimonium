/mob
	var/list/inventory_slots = list()

/mob/proc/DropItem(var/obj/item/thing)
	if(!istype(thing)) return FALSE
	thing.BeforeDropped()
	thing.ForceMove(get_turf(src))
	thing.AfterDropped(src)
	for(var/invslot in inventory_slots)
		var/obj/ui/inv/inv_slot = inventory_slots[invslot]
		if(istype(inv_slot) && inv_slot.holding == thing)
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

	if(istype(thing.loc, /obj/structure))
		var/obj/structure/struct = thing.loc
		if(struct.contains)
			struct.contains -= thing
		struct.ThingTakenOut(thing)
	else if(istype(thing.loc, /mob))
		var/mob/mob = thing.loc
		mob.DropItem(thing)

	thing.ForceMove(src)
	thing.AfterPickedUp(src)
	equipping.SetHeld(thing)
	UpdateIcon()
	return TRUE

/mob/proc/CollectItemOrDel(var/obj/item/thing, var/equip_to_slot)
	if(!CollectItem(thing, equip_to_slot))
		QDel(thing, "collection failed")
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
				var/obj/item/limb/limb = GetLimb(thing)
				if(istype(limb))
					limb.SetNotMoving(slot.holding ? TRUE : FALSE)

/mob/proc/GetHeatInsulation(var/slot)
	var/obj/item/covering = GetEquipped(slot)
	return (istype(covering) ? covering.GetHeatInsulation() : 0)

/mob/proc/TryPutInHands(var/obj/item/thing)
	if(!CollectItem(thing, GetSlotByHandedness("left")) && !CollectItem(thing, GetSlotByHandedness("right")))
		thing.ForceMove(get_turf(src))
