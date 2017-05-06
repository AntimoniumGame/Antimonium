/mob
	var/next_move = 0
	var/walking = TRUE
	var/walk_delay = 2
	var/run_delay = 1

/mob/Move()
	if(world.time < next_move)
		return 0
	. = ..()
	next_move = world.time + get_move_delay()

/mob/get_move_delay()
	return loc.get_mover_delay(src) + (walking ? walk_delay : run_delay)