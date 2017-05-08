/proc/is_adjacent_to(var/atom/first, var/atom/second)
	return get_dist(first, second) <= 1
