/mob
	var/list/injured_limbs = list()
	var/list/limbs = list()

/mob/proc/can_use_limb(var/slot)
	var/obj/item/limb/hand = limbs[slot]
	if(!istype(hand))
		notify("You are missing that limb!")
		return FALSE
	if(hand.broken)
		notify("Your [hand.name] is broken and unusable.")
		return FALSE
	return TRUE

/mob/proc/create_limbs() //placeholder
	limbs[BP_CHEST] =      new /obj/item/limb(src,       "upper body",  'icons/objects/items/limbs/chest.dmi',      BP_CHEST ,     _root = TRUE, _vital = TRUE, _size = 10)
