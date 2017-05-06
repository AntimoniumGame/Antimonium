/image/master_plane
	name = ""
	blend_mode = BLEND_MULTIPLY
	appearance_flags = PLANE_MASTER
	color = list(null,null,null,"#0000","#000f")
	mouse_opacity = 0
	plane = MASTER_PLANE
	screen_loc = "CENTER,CENTER"

/image/lighting_plane
	name = ""
	blend_mode = BLEND_ADD
	icon = 'icons/images/barrier.dmi'
	alpha = 220
	mouse_opacity = 0
	plane = LIGHTING_PLANE
	screen_loc = "CENTER,CENTER"

/image/lighting_plane/New()
	..()
	var/matrix/M = matrix()
	M.Scale(SCREEN_BARRIER_SIZE)
	transform = M