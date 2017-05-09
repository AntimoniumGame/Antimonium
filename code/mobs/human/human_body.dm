/mob/human
	var/list/limbs = list()

/mob/human/proc/create_limbs()

	// Order is important; make sure limbs with parents are created AFTER their parent.
	limbs[BP_CHEST] =      new /obj/item/limb(src,       "upper body", 'icons/objects/items/limbs/chest.dmi',       BP_CHEST ,     _root = TRUE, _vital = TRUE)
	limbs[BP_GROIN] =      new /obj/item/limb(src,       "lower body", 'icons/objects/items/limbs/groin.dmi',       BP_GROIN,      BP_CHEST,     _vital = TRUE)
	limbs[BP_LEFT_ARM] =   new /obj/item/limb(src,        "left arm",   'icons/objects/items/limbs/left_arm.dmi',   BP_LEFT_ARM,   BP_CHEST)
	limbs[BP_RIGHT_ARM] =  new /obj/item/limb(src,        "right arm",  'icons/objects/items/limbs/right_arm.dmi',  BP_RIGHT_ARM,  BP_CHEST)
	limbs[BP_HEAD] =       new /obj/item/limb(src,        "head",       'icons/objects/items/limbs/head.dmi',       BP_HEAD,       BP_CHEST,     _vital = TRUE)
	limbs[BP_LEFT_HAND] =  new /obj/item/limb/grasp(src,  "left hand",  'icons/objects/items/limbs/left_hand.dmi',  BP_LEFT_HAND,  BP_LEFT_ARM)
	limbs[BP_RIGHT_HAND] = new /obj/item/limb/grasp(src,  "right hand", 'icons/objects/items/limbs/right_hand.dmi', BP_RIGHT_HAND, BP_RIGHT_ARM)
	limbs[BP_LEFT_LEG] =   new /obj/item/limb/stance(src, "left leg",   'icons/objects/items/limbs/left_leg.dmi',   BP_LEFT_LEG,   BP_GROIN)
	limbs[BP_RIGHT_LEG] =  new /obj/item/limb/stance(src, "right leg",  'icons/objects/items/limbs/right_leg.dmi',  BP_RIGHT_LEG,  BP_GROIN)
	limbs[BP_LEFT_FOOT] =  new /obj/item/limb/stance(src, "left foot",  'icons/objects/items/limbs/left_foot.dmi',  BP_LEFT_FOOT,  BP_LEFT_LEG)
	limbs[BP_RIGHT_FOOT] = new /obj/item/limb/stance(src, "right foot", 'icons/objects/items/limbs/right_foot.dmi', BP_RIGHT_FOOT, BP_RIGHT_LEG)

/mob/human/proc/check_hand(var/slot)
	var/obj/item/limb/grasp/hand = limbs[slot]
	if(!istype(hand))
		notify("You are missing that limb!")
		return FALSE
	if(hand.broken)
		notify("Your [hand.name] is broken and unusable.")
		return FALSE
	return TRUE