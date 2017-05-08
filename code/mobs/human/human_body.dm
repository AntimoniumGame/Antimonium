/mob/human
	var/list/limbs = list()

/mob/human/proc/create_limbs()

	// Order is important; make sure limbs with parents are created AFTER their parent.
	limbs["chest"] =      new /obj/item/limb(src,        "chest",      'icons/objects/items/limbs/chest.dmi')
	limbs["groin"] =      new /obj/item/limb(src,        "groin",      'icons/objects/items/limbs/groin.dmi',      "chest")
	limbs["left_arm"] =   new /obj/item/limb(src,        "left arm",   'icons/objects/items/limbs/left_arm.dmi',   "chest")
	limbs["right_arm"] =  new /obj/item/limb(src,        "right arm",  'icons/objects/items/limbs/right_arm.dmi',  "chest")
	limbs["head"] =       new /obj/item/limb(src,        "head",       'icons/objects/items/limbs/head.dmi',       "chest")
	limbs["left_hand"] =  new /obj/item/limb/grasp(src,  "left hand",  'icons/objects/items/limbs/left_hand.dmi',  "left_arm")
	limbs["right_hand"] = new /obj/item/limb/grasp(src,  "right hand", 'icons/objects/items/limbs/right_hand.dmi', "right_arm")
	limbs["left_leg"] =   new /obj/item/limb(src,        "left leg",   'icons/objects/items/limbs/left_leg.dmi',   "groin")
	limbs["right_leg"] =  new /obj/item/limb(src,        "right leg",  'icons/objects/items/limbs/right_leg.dmi',  "groin")
	limbs["left_foot"] =  new /obj/item/limb/stance(src, "left foot",  'icons/objects/items/limbs/left_foot.dmi',  "left_leg")
	limbs["right_foot"] = new /obj/item/limb/stance(src, "right foot", 'icons/objects/items/limbs/right_foot.dmi', "right_leg")
