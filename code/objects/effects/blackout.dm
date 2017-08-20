/obj/effect/blackout
	name = "darkness"
	plane = FADE_PLANE
	screen_loc = "CENTER"
	icon = 'icons/images/barrier.dmi'
	icon_state = ""
	color = BLACK

/obj/effect/blackout/UpdateIcon()
	return

/obj/effect/blackout/New()
	..()
	var/matrix/M = matrix()
	M.Scale(25) // TODO: make this better
	transform = M
