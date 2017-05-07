/mob
	icon = 'icons/mobs/mob.dmi'
	layer = TURF_LAYER
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

	light_power = 10
	light_range = 5
	light_color = BRIGHT_YELLOW
	light_type = LIGHT_SOFT_FLICKER

	if(light_obj)
		notify("Killed self light.")
		kill_light()
	else
		notify("Set self light.")
		set_light()

	sleep(5)
	if(light_obj)
		light_obj.follow_holder()