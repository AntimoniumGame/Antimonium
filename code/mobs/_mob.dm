/mob
	icon = 'icons/mobs/mob.dmi'
	layer = TURF_LAYER
	light_power = 2
	light_range = 5

/mob/New()
	..()
	mob_list += src
	set_light()

/mob/Login()

	. = ..()

	world << "[src] ([type]) login"

	if(!master_plane)
		master_plane = new(loc=src)

	if(!lighting_plane)
		lighting_plane = new(loc=src)

	client.eye = src
	client.perspective = MOB_PERSPECTIVE
	client.images += master_plane
	client.images += lighting_plane

/mob/destroy()
	mob_list -= src
	master_plane = null
	lighting_plane = null
	return ..()
