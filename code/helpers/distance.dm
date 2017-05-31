/proc/IsAdjacentTo(var/atom/first, var/atom/second)
	var/dist_threshold = 1
	if(istype(first, /atom/movable) && istype(second, /atom/movable))
		var/atom/movable/first_atom = first
		var/atom/movable/second_atom = second
		dist_threshold = max(1,max((first_atom.bound_height / TILE_WIDTH), (second_atom.bound_height / TILE_WIDTH))-1) //assuming square turfs.
	return get_dist(get_turf(first), get_turf(second)) <= dist_threshold

/proc/Trange(rad = 0, var/turf/centre) //alternative to range (ONLY processes turfs and thus less intensive)
	centre = get_turf(centre)
	if(!istype(centre)) return
	var/turf/x1y1 = locate(((centre.x-rad)<1 ? 1 : centre.x-rad),((centre.y-rad)<1 ? 1 : centre.y-rad),centre.z)
	var/turf/x2y2 = locate(((centre.x+rad)>world.maxx ? world.maxx : centre.x+rad),((centre.y+rad)>world.maxy ? world.maxy : centre.y+rad),centre.z)
	return block(x1y1,x2y2)
