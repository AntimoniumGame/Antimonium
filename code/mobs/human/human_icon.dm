/mob/human/update_icon()

	// Reset and prepare for new overlays.
	overlays.Cut()
	var/list/new_overlays = list()

	// Generate bodyparts.
	for(var/limbstate in list("left_foot", "right_foot", "left_leg", "right_leg", "groin", "chest", "left_hand", "right_hand", "left_arm", "right_arm", "head"))
		var/obj/item/limb/limb = limbs[limbstate]
		if(istype(limb))
			new_overlays += limb.get_worn_icon("mob")

	// Generate clothing and gear.
	for(var/invslot in inventory_slots)
		var/obj/ui/inv/inv_slot = inventory_slots[invslot]
		if(inv_slot.holding)
			new_overlays += inv_slot.holding.get_worn_icon(inv_slot.slot_id)

	// Apply.
	overlays = new_overlays

