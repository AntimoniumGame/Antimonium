/obj/plane
	name = ""
	screen_loc = "CENTER"
	blend_mode = BLEND_MULTIPLY
	plane = SCREEN_PLANE // Needs to render over the top of darkness.
	layer = 2

/obj/plane/New(var/client/C)
	..()
	if(istype(C)) C.screen += src
	verbs.Cut()

/obj/plane/master
	appearance_flags = NO_CLIENT_COLOR | PLANE_MASTER | RESET_TRANSFORM | RESET_COLOR | RESET_ALPHA
	color = list(null,null,null,"#0000","#000f")  // Completely black.
	plane = MASTER_PLANE
