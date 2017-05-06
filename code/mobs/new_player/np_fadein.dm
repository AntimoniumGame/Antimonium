/mob/new_player/Login()
	. = ..()

	// Create the fadein overlay if needed.
	if(!blackout)
		blackout = new()
		blackout.name = "Antimonium"
		blackout.layer = SCREEN_EFFECTS_LAYER+0.5
		blackout.plane = SCREEN_PLANE
		blackout.screen_loc = "CENTER"
		blackout.icon = 'icons/images/barrier.dmi'
		blackout.icon_state = ""
		blackout.color = BLACK
		var/matrix/M = matrix()
		M.Scale(SCREEN_BARRIER_SIZE)
		blackout.transform = M

	// Add it to client.
	blackout.alpha = 255
	blackout.mouse_opacity = 1
	client.screen += blackout

	// Fade it out.
	spawn(0)
		animate(blackout, alpha=0, time=20)
		sleep(20)
		blackout.mouse_opacity = 0
	. = ..()