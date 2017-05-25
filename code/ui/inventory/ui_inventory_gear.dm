/obj/ui/inv/gear
	name = "gear slot"
	concealable = TRUE

/obj/ui/inv/gear/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	. = ..()
	if(.)
		TryEquipmentInteraction(slot)

/obj/ui/inv/gear/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	. = ..()
	if(.)
		TryEquipmentInteraction(slot)

/obj/ui/inv/gear/proc/TryEquipmentInteraction(var/slot)
	var/obj/item/prop = owner.GetEquipped(slot)
	if(prop)
		if(holding)
			holding.AttackedBy(owner, prop)
		else
			var/obj/ui/inv/inv_slot = owner.inventory_slots[slot]
			if(!(slot_flags & prop.slot_flags))
				owner.Notify("You cannot wear \the [prop] on your [unmodified_name].")
				return

			inv_slot.ForgetHeld()
			SetHeld(prop)

			PlayLocalSound(owner, prop.equip_sound, 100)
			owner.NotifyNearby("\The [owner] begins wearing \the [prop] on [owner.Their()] [unmodified_name].")
	else
		if(holding)
			var/obj/ui/inv/inv_slot = owner.inventory_slots[slot]
			prop = holding
			if(!prop.BeforeRemoved(owner, slot))
				return
			ForgetHeld()
			inv_slot.SetHeld(prop)
			PlayLocalSound(owner, prop.equip_sound, 100)
			owner.NotifyNearby("\The [owner] removes \the [prop] from [owner.Their()] [unmodified_name].")
			prop.AfterRemoved(owner, slot)
	owner.UpdateIcon()
