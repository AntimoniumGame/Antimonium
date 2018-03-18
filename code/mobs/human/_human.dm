/mob/human
	name = "human"
	cold_harm_point =   225
	cold_suffer_point = 250
	heat_suffer_point = 325
	heat_harm_point =   350
	weight = 60
	flags = FLAG_FLAMMABLE | FLAG_SIMULATED | FLAG_THROWN_SPIN
	ideal_sight_value = 4
	draw_shadow_underlay = TRUE

/mob/human/GetSlotByHandedness(var/handedness)
	return (handedness == "left" ? SLOT_LEFT_HAND : SLOT_RIGHT_HAND)

/mob/human/Initialize()
	. = ..()
	var/obj/item/limb/head/head = GetLimb(BP_HEAD)
	if(istype(head))
		head.SetHairStyle(pick(_glob.hair_styles))
		head.SetHairColour(pick(_glob.hair_colours))
		head.SetEyeColour(pick(_glob.eye_colours))