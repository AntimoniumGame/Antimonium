/var/list/slots_by_layer = list(
	BP_LEFT_FOOT =    TRUE,
	BP_RIGHT_FOOT =   TRUE,
	BP_LEFT_LEG =     TRUE,
	BP_RIGHT_LEG =    TRUE,
	SLOT_FEET =       FALSE,
	BP_GROIN =        TRUE,
	SLOT_LOWER_BODY = FALSE,
	SLOT_LEFT_HAND =  FALSE,
	SLOT_RIGHT_HAND = FALSE,
	BP_LEFT_HAND =    TRUE,
	BP_RIGHT_HAND =   TRUE,
	SLOT_HANDS =      FALSE,
	SLOT_LEFT_RING =  FALSE,
	SLOT_RIGHT_RING = FALSE,
	BP_CHEST =        TRUE,
	BP_LEFT_ARM =     TRUE,
	BP_RIGHT_ARM =    TRUE,
	SLOT_ARMS =       FALSE,
	SLOT_UPPER_BODY = FALSE,
	SLOT_NECK =       FALSE,
	SLOT_BACK =       FALSE,
	BP_HEAD =         TRUE,
	SLOT_HEAD =       FALSE,
	SLOT_EYES =       FALSE
	)

/mob/human // Ease of mapping.
	icon = 'icons/mobs/human_full.dmi'

/mob/human/update_icon()
	icon = null
	var/list/new_overlays = list()
	for(var/slot in slots_by_layer)
		if(slots_by_layer[slot])
			var/obj/item/limb/limb = limbs[slot]
			if(istype(limb)) new_overlays += limb.get_worn_icon(prone ? "world" : "mob")
		else
			var/obj/ui/inv/inv_slot = inventory_slots[slot]
			if(istype(inv_slot) && inv_slot.holding)
				if(prone)
					new_overlays += inv_slot.holding.get_prone_worn_icon(inv_slot.slot_id)
				else
					new_overlays += inv_slot.holding.get_worn_icon(inv_slot.slot_id)
	overlays = new_overlays
