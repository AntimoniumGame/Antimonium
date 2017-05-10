/mob
	var/next_move = 0
	var/walking = TRUE
	var/walk_delay = 2
	var/run_delay = 1

/mob/can_move()
	return (dragged || (world.time >= next_move))

/mob/Move()
	if(no_dead_move() && dead && !dragged)
		return FALSE
	. = ..()
	if(.)
		next_move = world.time + get_move_delay()

/mob/proc/no_dead_move()
	return TRUE

/mob/get_move_delay()
	return (loc ? loc.get_mover_delay(src) : 0) + (walking ? walk_delay : run_delay)

/mob/proc/Walk()
	walking = TRUE

/mob/proc/Run()
	walking = FALSE

/mob/set_dir(var/newdir)
	. = ..()
	turn_mob(newdir)

/mob/proc/turn_mob(var/newdir)
	var/matrix/M = matrix()
	M.Turn(dir2turn(newdir))
	transform = M

//code for controlling walk_dir is in /code/client/control.dm
/mob/proc/MoveLoop()
	set waitfor = 0
	while(client)
		if(loc && walk_dir)
			Move(get_step(src, walk_dir))
		WAIT_1T

/mob/Login()
	spawn()
		do_fadein(10)
	. = ..()
	MoveLoop()
