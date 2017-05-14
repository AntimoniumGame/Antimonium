// Mobs that do not have a physical presence or are
// otherwise not fully part of the game world.
/mob/abstract
	invisibility = INVISIBILITY_MAXIMUM

/mob/abstract/create_limbs()
	return

/mob/abstract/turn_mob(var/newdir)
	return

/mob/abstract/no_dead_move()
	return FALSE

/mob/abstract/get_move_delay()
	return 1

/mob/abstract/create_ui()
	// This is simply to avoid a null intent selector runtime.
	intent = new(src) // It doesn't need to be tracked or accessible.

/mob/abstract/left_click_on(var/atom/thing, var/ctrl, var/alt)
	return

/mob/abstract/right_click_on(var/atom/thing, var/ctrl, var/alt)
	return

/mob/abstract/middle_click_on(var/atom/thing, var/ctrl, var/alt)
	return

/mob/abstract/handle_life_tick()
	return

/mob/abstract/examined_by(var/mob/clicker)
	clicker.notify("That's a spooky ghost!")