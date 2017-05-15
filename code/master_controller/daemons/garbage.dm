var/datum/daemon/garbage/gc
/datum/var/gc_collect_time = 0

/proc/deleted(var/atom/A)
	return (!istype(A) || (A.gc_collect_time != 0 && !isnull(A.gc_collect_time)))

/datum/proc/destroy()
	return 1

/atom/destroy()
	name = "[name] (DESTROYED, REPORT THIS BUG)"
	if(contents)
		for(var/thing in contents)
			qdel(thing)
	return 1

/atom/movable/destroy()
	. = ..()
	loc = null

/image/destroy()
	del(src)

// placeholder for later
/proc/qdel(var/thing)
	gc.collect(thing)

/datum/daemon/garbage
	name = "garbage collector"
	delay = 50
	var/garbage_timeout = 200
	var/list/garbage = list()

/datum/daemon/garbage/New()
	if(gc)
		garbage = gc.garbage
		qdel(gc)
	gc = src

/datum/daemon/garbage/proc/collect(var/thing)
	if(!thing || !thing:destroy())
		return
	thing:gc_collect_time = world.time
	garbage["\ref[thing]"] = world.time

/datum/daemon/garbage/do_work()
	for(var/gref in garbage)
		var/timeout = garbage[gref]
		if(world.time < timeout+garbage_timeout)
			continue
		var/trash = locate(gref)
		if(trash && trash:gc_collect_time == timeout)
			del(trash)
		garbage[gref] = null
		garbage -= gref
		check_suspend()

/datum/daemon/garbage/status()
	return "[garbage.len] queued"