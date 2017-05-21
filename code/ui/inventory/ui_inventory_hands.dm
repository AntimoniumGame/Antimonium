/obj/ui/inv/hand
	name = "left hand"
	screen_loc = "7,2"

/obj/ui/inv/hand/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	. = ..()
	if(.)
		if(slot == slot_id)
			if(holding)
				holding.Use(owner)
		else if(slot == SLOT_LEFT_HAND)
			DoHandSwitch(SLOT_LEFT_HAND, SLOT_RIGHT_HAND)

/obj/ui/inv/hand/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	. = ..()
	if(.)
		if(slot == slot_id)
			if(holding)
				holding.Use(owner)
		else if(slot == SLOT_RIGHT_HAND)
			DoHandSwitch(SLOT_RIGHT_HAND, SLOT_LEFT_HAND)

/obj/ui/inv/hand/proc/DoHandSwitch(var/first_slot, var/second_slot)
	if(slot_id == second_slot)
		var/obj/ui/inv/inv_slot = owner.inventory_slots[first_slot]
		if(holding && inv_slot.holding)
			holding.AttackedBy(owner, inv_slot.holding)
		else if(holding)
			var/obj/item/prop = holding
			ForgetHeld()
			inv_slot.SetHeld(prop)
			owner.NotifyNearby("\The [owner] switches \the [prop] from [owner.Their()] [unmodified_name] to [owner.Their()] [inv_slot.unmodified_name].")
		else if(inv_slot.holding)
			var/obj/item/prop = inv_slot.holding
			inv_slot.ForgetHeld()
			SetHeld(prop)
			owner.NotifyNearby("\The [owner] switches \the [prop] from [owner.Their()] [inv_slot.unmodified_name] to [owner.Their()] [unmodified_name].")
	owner.UpdateIcon()

/obj/ui/inv/hand/MiddleClickedOn(var/mob/clicker)
	. = ..()
	if(. && holding)
		owner.NotifyNearby("\The [owner] drops \the [holding] from [owner.Their()] [unmodified_name].")
		owner.DropItem(holding)
