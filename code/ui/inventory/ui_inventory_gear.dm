/obj/ui/inv/gear
	name = "gear slot"
	concealable = TRUE

/obj/ui/inv/gear/left_clicked_on(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	. = ..()
	if(.)
		try_equipment_interaction(slot)

/obj/ui/inv/gear/right_clicked_on(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	. = ..()
	if(.)
		try_equipment_interaction(slot)

/obj/ui/inv/gear/proc/try_equipment_interaction(var/slot)
	var/obj/item/prop = owner.get_equipped(slot)
	if(prop)
		if(holding)
			holding.attacked_by(owner, prop)
		else
			var/obj/ui/inv/inv_slot = owner.inventory_slots[slot]
			if(!(slot_flags & prop.slot_flags))
				owner.notify("You cannot wear \the [prop] on your [unmodified_name].")
				return

			inv_slot.forget_held()
			set_held(prop)

			play_local_sound(owner, prop.equip_sound, 100)
			owner.notify_nearby("\The [owner] begins wearing \the [prop] on [owner.their()] [unmodified_name].")
	else
		if(holding)
			var/obj/ui/inv/inv_slot = owner.inventory_slots[slot]
			prop = holding
			forget_held()
			inv_slot.set_held(prop)
			play_local_sound(owner, prop.equip_sound, 100)
			owner.notify_nearby("\The [owner] removes \the [prop] from [owner.their()] [unmodified_name].")
	owner.update_icon()
