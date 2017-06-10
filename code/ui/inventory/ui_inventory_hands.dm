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
	if(owner.OnActionCooldown())
		return
	if(slot_id == second_slot)
		var/obj/ui/inv/inv_slot = owner.inventory_slots[first_slot]
		if(holding && inv_slot.holding)
			if(holding.AttackedBy(owner, inv_slot.holding))
				owner.SetActionCooldown(3)
		else if(holding)
			var/obj/item/prop = holding
			ForgetHeld()
			inv_slot.SetHeld(prop)
		else if(inv_slot.holding)
			var/obj/item/prop = inv_slot.holding
			inv_slot.ForgetHeld()
			SetHeld(prop)
	owner.UpdateIcon()

/obj/ui/inv/hand/MiddleClickedOn(var/mob/clicker)
	. = ..()
	if(. && holding)
		owner.NotifyNearby("<span class = 'notice'>\The [owner] drops \the [holding] from [owner.Their()] [unmodified_name].</span>")
		owner.DropItem(holding)
