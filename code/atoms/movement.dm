/atom/movable/proc/null_loc()
	loc = null

//force_move code courtesey of Ter13 - http://www.byond.com/forum/?post=2101373
/atom/movable/proc/force_move(atom/NewLoc, Dir = 0)
	var/OldLoc = loc
	if(!Dir)
		Dir = dir
	if(isturf(NewLoc) && isturf(loc))
		if(z == NewLoc.z)
			var/dx = (x * TILE_WIDTH) - (NewLoc.x * TILE_WIDTH), dy = (y * TILE_HEIGHT) - (NewLoc.y * TILE_HEIGHT)
			if(!dx && !dy)
				if(dir != Dir)
					dir = Dir
					return 1
				else
					return 0
	else if(loc == NewLoc)
		if(dir != Dir)
			dir = Dir
			return 1
		else
			return 0

	var/list/olocs, list/nlocs
	var/list/oareas = list(), list/nareas = list()
	var/list/oobjs, list/nobjs

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

	var/list/xareas = oareas-nareas, list/eareas = nareas-oareas
	var/list/xlocs = olocs-nlocs, list/elocs = nlocs-olocs
	var/list/xobjs = oobjs-nobjs, list/eobjs = nobjs-oobjs

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

	return 1

/atom/proc/get_mover_delay(var/atom/movable/mover)
	return 0

/atom/movable/proc/can_move()
	return TRUE

/atom/movable/proc/get_move_delay()
	return 3

/atom/movable/Move()
	if(!can_move())
		return 0
	//set the glide size for silky smooth movement
	if(self_move) //Atoms moving themselves get auto set glide size - anything else moving an object has to handle it manually
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
