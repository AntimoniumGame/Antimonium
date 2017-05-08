/mob/human/create_ui()

	// Gear slots (equipping items)
	inventory_slots[SLOT_LEFT_RING] =  new /obj/ui/inv/gear(src, "left ring finger",  "2,1", SLOT_LEFT_RING,  SLOT_FLAG_RING)
	inventory_slots[SLOT_RIGHT_RING] = new /obj/ui/inv/gear(src, "right ring finger", "3,1", SLOT_RIGHT_RING, SLOT_FLAG_RING)
	inventory_slots[SLOT_LOWER_BODY] = new /obj/ui/inv/gear(src, "lower body", "1,2", SLOT_LOWER_BODY, SLOT_FLAG_LOWER_BODY)
	inventory_slots[SLOT_FEET] =       new /obj/ui/inv/gear(src, "feet",       "2,2", SLOT_FEET,       SLOT_FLAG_FEET)
	inventory_slots[SLOT_BACK] =       new /obj/ui/inv/gear(src, "back",       "3,2", SLOT_BACK,       SLOT_FLAG_BACK)
	inventory_slots[SLOT_UPPER_BODY] = new /obj/ui/inv/gear(src, "upper body", "1,3", SLOT_UPPER_BODY, SLOT_FLAG_UPPER_BODY)
	inventory_slots[SLOT_ARMS] =       new /obj/ui/inv/gear(src, "arms",       "2,3", SLOT_ARMS,       SLOT_FLAG_ARMS)
	inventory_slots[SLOT_HANDS] =      new /obj/ui/inv/gear(src, "hands",      "3,3", SLOT_HANDS,      SLOT_FLAG_HANDS)
	inventory_slots[SLOT_HEAD] =       new /obj/ui/inv/gear(src, "head",       "1,4", SLOT_HEAD,       SLOT_FLAG_HEAD)
	inventory_slots[SLOT_EYES] =       new /obj/ui/inv/gear(src, "eyes",       "2,4", SLOT_EYES,       SLOT_FLAG_EYES)
	inventory_slots[SLOT_NECK] =       new /obj/ui/inv/gear(src, "neck",       "3,4", SLOT_NECK,       SLOT_FLAG_NECK)

	ui_screen += new /obj/ui/hide_inv(src)

	// Hand slots (holding items)
	inventory_slots[BP_LEFT_HAND] =  new /obj/ui/inv/hand(src, "left hand",  "7,1", BP_LEFT_HAND)
	inventory_slots[BP_RIGHT_HAND] = new /obj/ui/inv/hand(src, "right hand", "8,1", BP_RIGHT_HAND)

	for(var/slot in inventory_slots)
		ui_screen += inventory_slots[slot]