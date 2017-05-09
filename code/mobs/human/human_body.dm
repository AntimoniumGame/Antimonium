/mob/human
	var/list/limbs = list()

/mob/human/proc/create_limbs()

	// Order is important; make sure limbs with parents are created AFTER their parent.
	limbs[BP_CHEST] =      new /obj/item/limb(src,        "upper body", 'icons/objects/items/limbs/chest.dmi')
	limbs[BP_GROIN] =      new /obj/item/limb(src,       "lower body", 'icons/objects/items/limbs/groin.dmi',       BP_CHEST)
	limbs[BP_LEFT_ARM] =   new /obj/item/limb(src,        "left arm",   'icons/objects/items/limbs/left_arm.dmi',   BP_CHEST)
	limbs[BP_RIGHT_ARM] =  new /obj/item/limb(src,        "right arm",  'icons/objects/items/limbs/right_arm.dmi',  BP_CHEST)
	limbs[BP_HEAD] =       new /obj/item/limb(src,        "head",       'icons/objects/items/limbs/head.dmi',       BP_CHEST)
	limbs[BP_LEFT_HAND] =  new /obj/item/limb/grasp(src,  "left hand",  'icons/objects/items/limbs/left_hand.dmi',  BP_LEFT_ARM)
	limbs[BP_RIGHT_HAND] = new /obj/item/limb/grasp(src,  "right hand", 'icons/objects/items/limbs/right_hand.dmi', BP_RIGHT_ARM)
	limbs[BP_LEFT_LEG] =   new /obj/item/limb(src,        "left leg",   'icons/objects/items/limbs/left_leg.dmi',   BP_GROIN)
	limbs[BP_RIGHT_LEG] =  new /obj/item/limb(src,        "right leg",  'icons/objects/items/limbs/right_leg.dmi',  BP_GROIN)
	limbs[BP_LEFT_FOOT] =  new /obj/item/limb/stance(src, "left foot",  'icons/objects/items/limbs/left_foot.dmi',  BP_LEFT_LEG)
	limbs[BP_RIGHT_FOOT] = new /obj/item/limb/stance(src, "right foot", 'icons/objects/items/limbs/right_foot.dmi',  BP_RIGHT_LEG)
