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
	. = ..()
	set_dir(dir)
	if(. && light_obj)
		light_obj.follow_holder()

/atom/proc/set_dir(var/newdir)
	dir = newdir
	if(light_obj)
		light_obj.follow_holder_dir()
