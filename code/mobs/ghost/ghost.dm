/mob/ghost
	name = "ghost"
	icon = 'icons/mobs/ghost.dmi'
	dead = TRUE
	density = 0
	see_invisible = INVISIBILITY_GHOST
	invisibility = INVISIBILITY_GHOST
	sight = SEE_TURFS|SEE_MOBS|SEE_OBJS|SEE_SELF
	alpha = 130

/mob/ghost/turn_mob(var/newdir)
	return

/mob/ghost/no_dead_move()
	return FALSE

/mob/ghost/get_move_delay()
	return 1

/mob/ghost/create_ui()
	return

/mob/ghost/left_click_on(var/atom/thing, var/ctrl, var/alt)
	return

/mob/ghost/right_click_on(var/atom/thing, var/ctrl, var/alt)
	return

/mob/ghost/middle_click_on(var/atom/thing, var/ctrl, var/alt)
	return
