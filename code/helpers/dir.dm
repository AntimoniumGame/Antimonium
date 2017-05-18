/proc/align_with_wall(var/atom/movable/thing)
	for(var/checkdir in cardinal_dirs)
		var/turf/neighbor = get_step(thing, checkdir)
		if(neighbor.density)
			thing.set_dir(get_dir(neighbor, thing.loc))
			return
	thing.set_dir(0)
