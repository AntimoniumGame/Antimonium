/mob/animal/nymph
	name = "nymph"
	icon_state = "nymph"
	stance_limbs = list(BP_CHEST, BP_GROIN)
	stance_fail_threshold = 0

/mob/animal/nymph/CreateLimbs()
	// Order is important; make sure limbs with parents are created AFTER their parent.
	limbs[BP_CHEST] = new /obj/item/limb/stance(src, "body", 'icons/objects/items/limbs/diona/body.dmi', BP_CHEST, _root = TRUE, _vital = TRUE, _size = 10)
	limbs[BP_GROIN] = new /obj/item/limb/stance(src, "tail", 'icons/objects/items/limbs/diona/tail.dmi', BP_GROIN, BP_CHEST,     _vital = TRUE, _size = 10)
	limbs[BP_HEAD] =  new /obj/item/limb(src, "head", 'icons/objects/items/limbs/diona/head.dmi',  BP_HEAD,  BP_CHEST,     _vital = TRUE, _size = 10)

/mob/animal/nymph/ScrambleSpeech(var/message)
	return "chirps!"

/mob/animal/nymph/IsDigger(var/complex_digging = FALSE)
	return TRUE
