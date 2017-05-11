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
