/mob
	var/list/injured_limbs = list()
	var/list/limbs = list()
	var/sitting = FALSE

/mob/proc/CanUseLimb(var/slot)
	var/obj/item/limb/hand = limbs[slot]
	if(!istype(hand))
		Notify("You are missing that limb!")
		return FALSE
	if(hand.broken)
		Notify("Your [hand.name] is broken and unusable.")
		return FALSE
	return TRUE

/mob/proc/CanUseInvSlot(var/slot)
	var/obj/ui/inv/inv_slot = inventory_slots[slot]
	if(!istype(inv_slot))
		Notify("You cannot use that limb.")
		return FALSE
	if(inv_slot.associated_limb)
		return CanUseLimb(inv_slot.associated_limb)
	return TRUE

/mob/proc/CreateLimbs() //placeholder
	limbs[BP_CHEST] =      new /obj/item/limb(src,       "upper body",  'icons/objects/items/limbs/chest.dmi',      BP_CHEST ,     _root = TRUE, _vital = TRUE, _size = 10)

/mob/proc/ToggleSitting()
	sitting = !sitting
	for(var/limb in list(BP_LEFT_LEG, BP_RIGHT_LEG, BP_LEFT_FOOT, BP_RIGHT_FOOT))
		var/obj/item/limb/bp = limbs[limb]
		if(istype(bp))
			bp.SetNotMoving(sitting)
	UpdateIcon()
