/mob/human/create_ui()

	inventory_slots["left_hand"] = new /obj/ui/inv/hand(src, "left hand", "7,2", "left_hand")
	inventory_slots["right_hand"] = new /obj/ui/inv/hand(src, "right hand", "8,2", "right_hand")

	for(var/slot in inventory_slots)
		ui_screen += inventory_slots[slot]