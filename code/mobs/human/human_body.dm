/mob/human
	var/datum/human_bodytype/bodytype

/mob/human/Destroy()
	bodytype = null
	. = ..()

/mob/human/CreateLimbs()
	if(!bodytype) bodytype = pick(glob.human_bodytypes)
	// Order is important; make sure limbs with parents are created AFTER their parent.
	limbs_by_key[BP_CHEST] =      new /obj/item/limb(src,       "upper body",  bodytype.GetIcon(BP_CHEST, gender),      BP_CHEST ,     _root = TRUE, _vital = TRUE, _size = 10)
	limbs_by_key[BP_GROIN] =      new /obj/item/limb(src,       "lower body",  bodytype.GetIcon(BP_GROIN, gender),      BP_GROIN,      BP_CHEST,     _vital = TRUE, _size = 10)
	limbs_by_key[BP_LEFT_ARM] =   new /obj/item/limb(src,        "left arm",   bodytype.GetIcon(BP_LEFT_ARM, gender),   BP_LEFT_ARM,   BP_CHEST,     _size = 6)
	limbs_by_key[BP_RIGHT_ARM] =  new /obj/item/limb(src,        "right arm",  bodytype.GetIcon(BP_RIGHT_ARM, gender),  BP_RIGHT_ARM,  BP_CHEST,     _size = 6)
	limbs_by_key[BP_HEAD] =       new /obj/item/limb(src,        "head",       bodytype.GetIcon(BP_HEAD, gender),       BP_HEAD,       BP_CHEST,     _size = 6)
	limbs_by_key[BP_LEFT_HAND] =  new /obj/item/limb/grasp(src,  "left hand",  bodytype.GetIcon(BP_LEFT_HAND, gender),  BP_LEFT_HAND,  BP_LEFT_ARM,  _size = 3)
	limbs_by_key[BP_RIGHT_HAND] = new /obj/item/limb/grasp(src,  "right hand", bodytype.GetIcon(BP_RIGHT_HAND, gender), BP_RIGHT_HAND, BP_RIGHT_ARM, _size = 3)
	limbs_by_key[BP_LEFT_LEG] =   new /obj/item/limb/stance(src, "left leg",   bodytype.GetIcon(BP_LEFT_LEG, gender),   BP_LEFT_LEG,   BP_GROIN,     _size = 6)
	limbs_by_key[BP_RIGHT_LEG] =  new /obj/item/limb/stance(src, "right leg",  bodytype.GetIcon(BP_RIGHT_LEG, gender),  BP_RIGHT_LEG,  BP_GROIN,     _size = 6)
	limbs_by_key[BP_LEFT_FOOT] =  new /obj/item/limb/stance(src, "left foot",  bodytype.GetIcon(BP_LEFT_FOOT, gender),  BP_LEFT_FOOT,  BP_LEFT_LEG,  _size = 3)
	limbs_by_key[BP_RIGHT_FOOT] = new /obj/item/limb/stance(src, "right foot", bodytype.GetIcon(BP_RIGHT_FOOT, gender), BP_RIGHT_FOOT, BP_RIGHT_LEG, _size = 3)

/mob/human/CreateOrgans()
	CreateDefaultInternalOrgans(src)
