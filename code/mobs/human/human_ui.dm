/mob/human/create_ui()

	inventory_slots["left_hand"] = new /obj/ui/inv/left_hand(src)
	inventory_slots["right_hand"] = new /obj/ui/inv/right_hand(src)

	for(var/slot in inventory_slots)
		ui_screen += inventory_slots[slot]