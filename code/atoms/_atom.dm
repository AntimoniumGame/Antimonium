/atom
	name = ""
	plane = MASTER_PLANE
	layer = UNDERLAY_LAYER
	var/simulated = TRUE

/atom/proc/is_adjacent_to(var/atom/other)
	return get_dist(src, other) <= 1