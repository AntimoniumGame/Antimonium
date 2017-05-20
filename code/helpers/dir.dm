/proc/AlignWithWall(var/atom/movable/thing)
	for(var/checkdir in cardinal_dirs)
		var/turf/neighbor = get_step(thing, checkdir)
		if(neighbor.density)
			thing.SetDir(get_dir(neighbor, thing.loc))
			return
	thing.SetDir(0)
