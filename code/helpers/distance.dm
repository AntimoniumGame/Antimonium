/proc/is_adjacent_to(var/atom/first, var/atom/second)
	return get_dist(get_turf(first), get_turf(second)) <= 1
