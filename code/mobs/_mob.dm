/mob
	icon = 'icons/mobs/_default.dmi'
	layer = TURF_LAYER
	see_invisible = SEE_INVISIBLE_LIVING

/mob/New()
	..()
	mob_list += src

/mob/destroy()
	mob_list -= src
	return ..()

/mob/proc/clicked_on(var/thing)
	return