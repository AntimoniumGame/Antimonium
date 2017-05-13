/area
	icon = 'icons/areas/areas.dmi'
	icon_state = "cave"

/area/lighting
	alpha = 255
	plane = SCREEN_PLANE
	var/light_level = 50

// For ease of mapping, the various visibility elements are applied at runtime.
/area/lighting/New()
	..()
	alpha = light_level
	icon_state = null
	icon = 'icons/lighting/over_dark.dmi'
	plane = DARK_PLANE // Just below the master plane.
	appearance_flags = RESET_TRANSFORM | RESET_COLOR | RESET_ALPHA
	blend_mode = BLEND_ADD

/area/lighting/indoors
	icon_state = "room"
	light_level = 120

/area/lighting/outdoors
	icon_state = "sky"
	light_level = 200

/* WIP
/turf/New()
	..()
	if(game_state && game_state != GAME_SETTING_UP)
		update_area_blending()

/turf/proc/update_area_blending(var/pass_it_on = FALSE)

	var/blend_dirs = list()
	var/area/my_area = loc

	if(!istype(my_area))
		return

	for(var/checkdir in all_dirs)
		var/turf/neighbor = get_step(src, checkdir)
		if(!istype(neighbor))
			continue
		if(pass_it_on)
			neighbor.update_area_blending()
		var/area/neighboring_area = neighbor.loc
		if(!istype(neighboring_area) || neighboring_area.alpha > my_area.alpha)
			continue
		blend_dirs += checkdir

	for(var/checkdir in blend_dirs)
		var/turf/neighbor = get_step(src, checkdir)
		var/obj/area_edge/edge
		for(var/obj/area_edge/old_edge in neighbor)
			if(dir == checkdir && old_edge.associated_area == my_area)
			edge = old_edge

/obj/area_edge
	name = ""
	simulated = FALSE
	anchored = TRUE
	mouse_opacity = 0
	var/area/associated_area

/obj/area_edge/New(var/newloc, var/area/_area)
	..()
	associated_area = _area
	verbs.Cut()
*/