/atom/proc/bumped(atom/movable/o)
	set waitfor = 0

/atom/Enter(atom/movable/o, atom/oldloc)
	return o.on_enter(src, oldloc, ..())

/atom/Exit(atom/movable/o, atom/newloc)
	return o.on_exit(src, newloc, ..())

/atom/Entered(atom/movable/o, atom/oldloc)
	o.on_entered(src, oldloc)
	..()

/atom/Exited(atom/movable/o, atom/newloc)
	o.on_exited(src, newloc)
	..()


/atom/movable/Cross(atom/movable/o)
	return o.on_cross(src, !(density && o.density && o.collision_mask & collision_layer))

/atom/movable/Uncross(atom/movable/o)
	return o.on_uncross(src, ..())

/atom/movable/Crossed(atom/movable/o)
	o.on_crossed(src)
	..()

/atom/movable/Uncrossed(atom/movable/o)
	o.on_uncrossed(src)
	..()

/atom/movable/Bump(atom/o)
	o.bumped(src)
	..()


/atom/movable/proc/on_enter(atom/o, atom/oldloc, retval)
	set waitfor = 0
	return retval

/atom/movable/proc/on_exit(atom/o, atom/newloc, retval)
	set waitfor = 0
	return retval

/atom/movable/proc/on_entered(atom/o, atom/oldloc)
	set waitfor = 0

/atom/movable/proc/on_exited(atom/o, atom/newloc)
	set waitfor = 0

/atom/movable/proc/on_cross(atom/movable/o, retval)
	set waitfor = 0
	return retval

/atom/movable/proc/on_uncross(atom/movable/o, retval)
	set waitfor = 0
	return retval

/atom/movable/proc/on_crossed(atom/movable/o)
	set waitfor = 0

/atom/movable/proc/on_uncrossed(atom/movable/o)
	set waitfor = 0


/atom/movable/proc/null_loc()
	loc = null

//force_move code courtesey of Ter13 - http://www.byond.com/forum/?post=2101373
/atom/movable/proc/force_move(atom/NewLoc, Dir = 0)
	var/OldLoc = loc
	var/oDir = dir
	if(!Dir) Dir = dir
	if(isturf(NewLoc) && isturf(loc))
		if(z == NewLoc.z)
			var/dx = (x * TILE_WIDTH) - (NewLoc.x * TILE_WIDTH)
			var/dy = (y * TILE_HEIGHT) - (NewLoc.y * TILE_HEIGHT)
			if(!dx && !dy)
				if(dir != Dir)
					dir = Dir
					moved(OldLoc, oDir)
					return TRUE
				else
					return FALSE
	else if(loc == NewLoc)
		if(dir != Dir)
			dir = Dir
			moved(OldLoc, oDir)
			return TRUE
		else
			return FALSE

	var/list/olocs
	var/list/nlocs
	var/list/oareas = list()
	var/list/nareas = list()
	var/list/oobjs
	var/list/nobjs

	olocs = locs
	if(isturf(loc))
		for(var/turf/t in olocs)
			oareas |= t.loc
		oobjs = obounds(src) || list()
		oobjs -= locs
	else
		oobjs = list()

	loc = NewLoc
	dir = Dir

	nlocs = locs
	if(isturf(loc))
		nlocs = locs
		for(var/turf/t in nlocs)
			nareas |= t.loc
		nobjs = obounds(src) || list()
		nobjs -= locs
	else
		nobjs = list()

	var/list/xareas = oareas-nareas
	var/list/eareas = nareas-oareas
	var/list/xlocs = olocs-nlocs
	var/list/elocs = nlocs-olocs
	var/list/xobjs = oobjs-nobjs
	var/list/eobjs = nobjs-oobjs

	for(var/area/a in xareas)
		a.Exited(src, loc)
	for(var/turf/t in xlocs)
		t.Exited(src, loc)
	for(var/atom/movable/o in xobjs)
		o.Uncrossed(src)

	for(var/area/a in eareas)
		a.Entered(src, OldLoc)
	for(var/turf/t in elocs)
		t.Entered(src, OldLoc)
	for(var/atom/movable/o in eobjs)
		o.Crossed(src)

	moved(OldLoc,oDir)
	return TRUE


/atom/proc/get_mover_delay(var/atom/movable/mover)
	return 0

/atom/movable/proc/can_move(atom/NewLoc, Dir=0)
	set waitfor = 0
	return TRUE

/atom/movable/proc/get_move_delay()
	return 3

/atom/movable/proc/moved(atom/OldLoc, oDir)
	set waitfor = 0

/atom/movable/Move(atom/NewLoc, Dir=0)
	var/oLoc = loc
	var/oDir = dir
	glide_size = world.icon_size / max(get_move_delay(), world.tick_lag) * world.tick_lag
	. = can_move(arglist(args)) && ..()
	if(. || dir != oDir)
		moved(oLoc, oDir)



/*
	if(!can_move())
		return 0
	//set the glide size for silky smooth movement
	if(self_move) //Atoms moving themselves get auto set glide size - anything else moving an object has to handle it manually
		glide_size = world.icon_size / max(get_move_delay(), world.tick_lag) * world.tick_lag
	. = ..()
	set_dir(dir)
	if(. && light_obj)
		light_obj.follow_holder()
*/
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
	return (!(flags & FLAG_ANCHORED) && (flags & FLAG_SIMULATED))

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
