/render_plane
	parent_type = /atom/movable
	appearance_flags = PLANE_MASTER | NO_CLIENT_COLOR
	screen_loc = "CENTER"

/render_plane/New(loc, new_plane, blending, clickable = 1)
	..()
	plane = new_plane
	blend_mode = blending
	mouse_opacity = clickable
