/mob
	icon = 'icons/mobs/mob.dmi'
	layer = TURF_LAYER
	light_power = 2
	light_range = 5
	see_invisible = SEE_INVISIBLE_LIVING

/mob/New()
	..()
	mob_list += src

/mob/destroy()
	mob_list -= src
	return ..()

/mob/verb/testlights()

	set name = "Toggle Self Light"
	set category = "Debug"

	if(light_obj)
		notify("Killed light.")
		kill_light()
	else
		notify("Set light.")
		set_light()

	sleep(5)
	if(light_obj)
		light_obj.follow_holder()