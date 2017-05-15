/mob
	density = 1
	icon = 'icons/mobs/_default.dmi'
	layer = MOB_LAYER
	see_invisible = SEE_INVISIBLE_LIVING
	var/weight = 50

/mob/get_weight()
	return weight

/mob/New()
	create_limbs()
	gender = pick(MALE, FEMALE, NEUTER, PLURAL)
	mob_list += src
	if(dead)
		dead_mob_list += src
	else
		living_mob_list += src
	..()

/mob/destroy()
	dead_mob_list -= src
	living_mob_list -= src
	mob_list -= src
	. = ..()

/mob/update_strings()
	..()
	if(key)
		name = key

/mob/face_atom()
	if(!prone || dragged)
		. = ..()
