/mob/human
	name = "human"
	density = 1

/mob/human/New()
	..()
	for(var/limbstate in list("left_foot", "right_foot", "left_leg", "right_leg", "groin", "chest", "left_hand", "right_hand", "left_arm", "right_arm", "head"))
		overlays += image(icon = 'icons/mobs/human_limbs.dmi', icon_state = limbstate)
