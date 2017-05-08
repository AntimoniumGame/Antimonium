/obj/ui/inv/hand
	name = "left hand"
	screen_loc = "7,2"
	slot_id = "left_hand"

/obj/ui/inv/hand/left_clicked_on(var/mob/clicker)
	. = ..()
	if(.)
		do_hand_switch("left_hand", "right_hand")

/obj/ui/inv/hand/right_clicked_on(var/mob/clicker)
	. = ..()
	if(.)
		do_hand_switch("right_hand", "left_hand")

/obj/ui/inv/hand/proc/do_hand_switch(var/first_slot, var/second_slot)
	if(slot_id == first_slot)
		if(holding)
			holding.use(owner)
	else if(slot_id == second_slot)
		var/obj/ui/inv/inv_slot = owner.inventory_slots[first_slot]
		if(holding && inv_slot.holding)
			holding.attacked_by(owner, inv_slot.holding)
		else if(holding)
			var/obj/item/prop = holding
			forget_held()
			inv_slot.set_held(prop)
			owner.notify_nearby("\The [owner] tosses \the [prop] from [owner.their()] [unmodified_name] to [owner.their()] [inv_slot.unmodified_name].")
		else if(inv_slot.holding)
			var/obj/item/prop = inv_slot.holding
			inv_slot.forget_held()
			set_held(prop)
			owner.notify_nearby("\The [owner] tosses \the [prop] from [owner.their()] [inv_slot.unmodified_name] to [owner.their()] [unmodified_name].")
	owner.update_icon()

/obj/ui/inv/hand/middle_clicked_on(var/mob/clicker)
	. = ..()
	if(. && holding)
		owner.drop_item(holding)
