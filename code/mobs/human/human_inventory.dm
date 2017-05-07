/mob/human
	var/list/inventory_slots = list()

/mob/human/collect_item(var/obj/item/thing)
	. = ..()
	if(.)
		var/obj/ui/inv/left_hand = inventory_slots["left_hand"]
		var/obj/ui/inv/right_hand = inventory_slots["right_hand"]
		if(left_hand.holding && right_hand.holding)
			notify("Your hands are full.")
			drop_item(thing)
			return FALSE
		else if(!left_hand.holding)
			left_hand.set_held(thing)
		else
			right_hand.set_held(thing)
		update_icon()

/mob/human/drop_item(var/obj/item/thing)
	. = ..()
	for(var/invslot in inventory_slots)
		var/obj/ui/inv/inv_slot = inventory_slots[invslot]
		if(inv_slot.holding == thing)
			inv_slot.forget_held()
			break
