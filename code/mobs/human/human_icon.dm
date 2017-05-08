/mob/human/update_icon()

	//TODO: limb and equipment layering.

	// Reset and prepare for new overlays.
	overlays.Cut()
	var/list/new_overlays = list()

	// Generate bodyparts.
	for(var/limbstate in ALL_HUMAN_LIMBS)
		var/obj/item/limb/limb = limbs[limbstate]
		if(istype(limb))
			new_overlays += limb.get_worn_icon(prone ? "world" : "mob")

	// Generate clothing and gear.
	for(var/invslot in inventory_slots)
		var/obj/ui/inv/inv_slot = inventory_slots[invslot]
		if(inv_slot.holding)
			if(prone)
				new_overlays += inv_slot.holding.get_prone_worn_icon(inv_slot.slot_id)
			else
				new_overlays += inv_slot.holding.get_worn_icon(inv_slot.slot_id)

	// Apply.
	overlays = new_overlays

