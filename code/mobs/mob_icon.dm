/mob
	var/mob_overlay_ident

/mob/UpdateIcon(var/list/supplied = list())
	icon = null
	var/image/I = image(null)
	var/list/limb_overlays = list()
	for(var/slot in inventory_slots_by_layer)
		if(inventory_slots_by_layer[slot])
			var/obj/item/limb/limb = limbs[slot]
			if(istype(limb)) limb_overlays += limb.GetWornIcon(prone ? "world" : "mob")
		else
			var/obj/ui/inv/inv_slot = inventory_slots[slot]
			if(istype(inv_slot) && inv_slot.holding)
				var/effective_ident = mob_overlay_ident ? "[mob_overlay_ident]-[inv_slot.slot_id]" : inv_slot.slot_id
				if(prone)
					limb_overlays += inv_slot.holding.GetProneWornIcon(effective_ident)
				else
					limb_overlays += inv_slot.holding.GetWornIcon(effective_ident)
	I.overlays = limb_overlays
	supplied += I
	..(supplied)
