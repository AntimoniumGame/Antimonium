/atom/movable/proc/move_to(var/destination)
	loc = destination
	if(light_obj)
		light_obj.follow_holder()

/atom/proc/get_mover_delay(var/atom/movable/mover)
	return 0

/atom/movable/proc/can_move()
	return TRUE

/atom/movable/proc/get_move_delay()
	return 0

/atom/movable/Move()
	if(!can_move())
		return 0

	//set the glide size for silky smooth movement
	if(!dragged) // Dragged atoms get their glide size set by the dragger.
		glide_size = world.icon_size / max(get_move_delay(), world.tick_lag) * world.tick_lag
	. = ..()
	set_dir(dir)
	if(. && light_obj)
		light_obj.follow_holder()

/atom/proc/set_dir(var/newdir)
	if(dir != newdir)
		dir = newdir
		if(light_obj)
			light_obj.follow_holder_dir()
		return TRUE
	return FALSE

/atom/proc/is_grabbable()
	return FALSE

/atom/movable/is_grabbable()
	return (!anchored && simulated)

/atom/proc/face_atom(var/atom/A)
	if(!A || !x || !y || !A.x || !A.y) return
	var/dx = A.x - x
	var/dy = A.y - y
	if(!dx && !dy) return

	var/direction
	if(abs(dx) < abs(dy))
		if(dy > 0)	direction = NORTH
		else		direction = SOUTH
	else
		if(dx > 0)	direction = EAST
		else		direction = WEST
	if(direction != dir)
		set_dir(direction)