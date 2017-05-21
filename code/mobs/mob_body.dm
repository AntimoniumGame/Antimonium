/mob
	var/list/injured_limbs = list()
	var/list/limbs = list()

/mob/proc/CanUseLimb(var/slot)
	var/obj/item/limb/hand = limbs[slot]
	if(!istype(hand))
		Notify("You are missing that limb!")
		return FALSE
	if(hand.broken)
		Notify("Your [hand.name] is broken and unusable.")
		return FALSE
	return TRUE

/mob/proc/CreateLimbs() //placeholder
	limbs[BP_CHEST] =      new /obj/item/limb(src,       "upper body",  'icons/objects/items/limbs/chest.dmi',      BP_CHEST ,     _root = TRUE, _vital = TRUE, _size = 10)
