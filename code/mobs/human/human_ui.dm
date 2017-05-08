/mob/human/create_ui()

	// Gear slots (equipping items)
	inventory_slots["left_ring"] =  new /obj/ui/inv/gear(src, "left ring",  "2,1", "left_ring")
	inventory_slots["right_ring"] = new /obj/ui/inv/gear(src, "right ring", "3,1", "right_ring")
	inventory_slots["lower_body"] = new /obj/ui/inv/gear(src, "lower body", "1,2", "lower_body")
	inventory_slots["feet"] =       new /obj/ui/inv/gear(src, "feet",       "2,2", "feet")
	inventory_slots["back"] =       new /obj/ui/inv/gear(src, "back",       "3,2", "back")
	inventory_slots["upper_body"] = new /obj/ui/inv/gear(src, "upper body", "1,3", "upper_body")
	inventory_slots["arms"] =       new /obj/ui/inv/gear(src, "arms",       "2,3", "arms")
	inventory_slots["hands"] =      new /obj/ui/inv/gear(src, "hands",      "3,3", "hands")
	inventory_slots["head"] =       new /obj/ui/inv/gear(src, "head",       "1,4", "head")
	inventory_slots["eyes"] =       new /obj/ui/inv/gear(src, "eyes",       "2,4", "eyes")
	inventory_slots["neck"] =       new /obj/ui/inv/gear(src, "neck",       "3,4", "neck")

	ui_screen += new /obj/ui/hide_inv(src)

	// Hand slots (holding items)
	inventory_slots["left_hand"] =  new /obj/ui/inv/hand(src, "left hand",  "7,1", "left_hand")
	inventory_slots["right_hand"] = new /obj/ui/inv/hand(src, "right hand", "8,1", "right_hand")

	for(var/slot in inventory_slots)
		ui_screen += inventory_slots[slot]