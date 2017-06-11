/mob
	var/mob_overlay_ident
	var/list/mob_overlays	// a list of all the overlays of objects and limbs for this mob

//only call this for a full icon update
/mob/UpdateIcon()
	icon = null

	UpdateMobIcons()
	UpdateShadowUnderlay()
	UpdateFireOverlay()

/mob/proc/UpdateMobIcons()
	overlays -= mob_overlays

	mob_overlays = list()

	for(var/slot in inventory_slots_by_layer)
		if(inventory_slots_by_layer[slot])
			mob_overlays += UpdateIconByLimb(slot)
		else
			mob_overlays += UpdateIconBySlot(slot)

	overlays += mob_overlays

/mob/proc/UpdateIconBySlot(var/slot)
	var/obj/ui/inv/inv_slot = inventory_slots[slot]
	if(istype(inv_slot) && inv_slot.holding)
		var/effective_ident = mob_overlay_ident ? "[mob_overlay_ident]-[inv_slot.slot_id]" : inv_slot.slot_id
		if(prone)
			return inv_slot.holding.GetProneWornIcon(effective_ident)
		else
			return inv_slot.holding.GetWornIcon(effective_ident)

/mob/proc/UpdateIconByLimb(var/limb_id)
	var/obj/item/limb/limb = limbs[limb_id]
	if(istype(limb))
		return limb.GetWornIcon(prone ? "world" : "mob")
