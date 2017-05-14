/obj/effect/blackout
	name = "Antimonium"
	layer = SCREEN_EFFECTS_LAYER+0.5
	plane = SCREEN_PLANE
	screen_loc = "CENTER"
	icon = 'icons/images/barrier.dmi'
	icon_state = ""
	color = BLACK

/obj/effect/blackout/New()
	..()
	var/matrix/M = matrix()
	M.Scale(SCREEN_BARRIER_SIZE)
	transform = M
