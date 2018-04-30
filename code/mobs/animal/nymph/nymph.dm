/mob/animal/nymph
	name = "nymph"
	icon_state = "nymph"
	stance_limbs = list(BP_CHEST, BP_GROIN)
	stance_fail_threshold = 0
	blood_material = /datum/material/water/ichor
	ideal_sight_value = 2

/mob/animal/nymph/CreateLimbs()
	// Order is important; make sure limbs with parents are created AFTER their parent.
	limbs_by_key[BP_CHEST] = new /obj/item/limb/stance(src, "body", 'icons/mobs/limbs/diona/body.dmi', BP_CHEST, _root = TRUE, _vital = TRUE, _length = 10, _width = 10, _height = 10)
	limbs_by_key[BP_GROIN] = new /obj/item/limb/stance(src, "tail", 'icons/mobs/limbs/diona/tail.dmi', BP_GROIN, BP_CHEST,     _vital = TRUE, _length = 10, _width = 10, _height = 10)
	limbs_by_key[BP_HEAD] =  new /obj/item/limb(src, "head", 'icons/mobs/limbs/diona/head.dmi',  BP_HEAD,  BP_CHEST,     _vital = TRUE, _length = 10, _width = 10, _height = 10)

/mob/animal/nymph/ScrambleSpeech(var/message)
	return "chirps!"

/mob/animal/nymph/IsDigger(var/complex_digging = FALSE)
	return TRUE
