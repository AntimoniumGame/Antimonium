/mob
	density = 1
	icon = 'icons/mobs/_default.dmi'
	layer = MOB_LAYER
	see_invisible = SEE_INVISIBLE_LIVING
	shadow_size = 2

	var/weight = 50
	var/datum/job/job
	var/burn_point = TEMPERATURE_BURNING

/mob/proc/GetSlotByHandedness(var/handedness)
	return null

/mob/GetWeight()
	return weight

/mob/New()
	CreateLimbs()
	gender = pick(MALE, FEMALE, NEUTER, PLURAL)
	mob_list += src
	if(dead)
		dead_mob_list += src
	else
		living_mob_list += src
	..()

/mob/Destroy()
	dead_mob_list -= src
	living_mob_list -= src
	mob_list -= src
	. = ..()

/mob/UpdateStrings()
	..()
	if(key)
		name = key

/mob/FaceAtom()
	if((!prone && !sitting) || dragged)
		. = ..()
