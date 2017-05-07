/mob
	var/next_move = 0
	var/walking = TRUE
	var/walk_delay = 2
	var/run_delay = 1

/mob/can_move()
	return (world.time >= next_move)

/mob/Move()
	. = ..()
	if(.)
		next_move = world.time + get_move_delay()

/mob/get_move_delay()
	return loc.get_mover_delay(src) + (walking ? walk_delay : run_delay)

/mob/proc/Walk()
	walking = TRUE

/mob/proc/Run()
	walking = FALSE

//code for controlling walk_dir is in /code/client/control.dm
/mob/proc/MoveLoop()
	set waitfor = 0
	while(client)
		if(loc && walk_dir)
			Move(get_step(src, walk_dir))
		WAIT_1T

/mob/Login()
	. = ..()
	MoveLoop()
