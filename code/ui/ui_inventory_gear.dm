/obj/ui/inv/gear
	name = "gear slot"
	concealable = TRUE

/obj/ui/inv/gear/left_clicked_on(var/mob/clicker)
	. = ..()
	if(.)
		try_equipment_interaction("left_hand")

/obj/ui/inv/gear/right_clicked_on(var/mob/clicker)
	. = ..()
	if(.)
		try_equipment_interaction("right_hand")

/obj/ui/inv/gear/middle_clicked_on(var/mob/clicker)
	clicker << output("It's \a [name].", "chatoutput")

/obj/ui/inv/gear/proc/try_equipment_interaction(var/slot)
	var/prop = owner.get_equipped(slot)
	if(prop)
		if(holding)
			holding.attacked_by(owner, prop)
		else
			var/obj/ui/inv/inv_slot = owner.inventory_slots[slot]
			inv_slot.forget_held()
			set_held(prop)
			owner.notify_nearby("\The [owner] begins wearing \the [prop].")
	else
		if(holding)
			var/obj/ui/inv/inv_slot = owner.inventory_slots[slot]
			prop = holding
			forget_held()
			inv_slot.set_held(prop)
			owner.notify_nearby("\The [owner] removes \the [prop].")
	owner.update_icon()
