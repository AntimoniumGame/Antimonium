/proc/IsAdjacentTo(var/atom/first, var/atom/second)
	return get_dist(get_turf(first), get_turf(second)) <= 1

/proc/Trange(rad = 0, var/turf/centre) //alternative to range (ONLY processes turfs and thus less intensive)
	centre = get_turf(centre)
	if(!istype(centre)) return
	var/turf/x1y1 = locate(((centre.x-rad)<1 ? 1 : centre.x-rad),((centre.y-rad)<1 ? 1 : centre.y-rad),centre.z)
	var/turf/x2y2 = locate(((centre.x+rad)>world.maxx ? world.maxx : centre.x+rad),((centre.y+rad)>world.maxy ? world.maxy : centre.y+rad),centre.z)
	return block(x1y1,x2y2)