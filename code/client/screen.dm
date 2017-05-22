/client
	var/list/screen_objs // screen objects that should always be rendered to the client
	var/list/image_objs  // image objects that should always be rendered to the client
	var/render_plane/master_plane
	var/render_plane/lighting_plane

/client/proc/RefreshUI()
	screen.len = 0
	screen |= screen_objs
	images.len = 0
	images |= image_objs

	if(mob)
		screen |= mob.ui_screen
		images |= mob.ui_images

	OnResize()

/client/New()
	screen_objs = list()
	image_objs = list()

	master_plane = new(null, MASTER_PLANE, BLEND_MULTIPLY)
	screen_objs += master_plane

	. = ..()
	//create render planes
//	var/render_plane/R = new /render_plane(locate(1,1,1), new_plane = MASTER_PLANE, blending = BLEND_MULTIPLY)
//	screen_objs += new /render_plane(MASTER_PLANE, BLEND_MULTIPLY) // master plane
//	screen_objs += new /render_plane(LIGHTING_PLANE, BLEND_OVERLAY, clickable = 0) // lighting plane, invisible to clicks

//	RefreshUI()
