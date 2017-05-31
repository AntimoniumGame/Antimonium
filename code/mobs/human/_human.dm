/mob/human
	name = "human"
	cold_harm_point =   225
	cold_suffer_point = 250
	heat_suffer_point = 325
	heat_harm_point =   350
	weight = 60
	sight = SEE_BLACKNESS

/mob/human/GetSlotByHandedness(var/handedness)
	return (handedness == "left" ? SLOT_LEFT_HAND : SLOT_RIGHT_HAND)
