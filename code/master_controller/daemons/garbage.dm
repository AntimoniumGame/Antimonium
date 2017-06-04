var/datum/daemon/garbage/gc
/datum/var/gc_collect_time = 0

/proc/Deleted(var/atom/A)
	return (!istype(A) || (A.gc_collect_time != 0 && !isnull(A.gc_collect_time)))

/datum/proc/Destroy()
	return 1

/atom/Destroy()
	if(contents)
		for(var/thing in contents)
			QDel(thing)
	return 1

/atom/movable/Destroy()
	. = ..()
	loc = null

/image/Destroy()
	del(src)

// placeholder for later
/proc/QDel(var/thing)
	gc.Collect(thing)

/datum/daemon/garbage
	name = "garbage collector"
	delay = 50
	var/garbage_timeout = 200
	var/list/garbage = list()

/datum/daemon/garbage/New()
	if(gc)
		garbage = gc.garbage
		QDel(gc)
	gc = src

/datum/daemon/garbage/proc/Collect(var/thing)
	if(!thing || !thing:Destroy())
		return
	thing:gc_collect_time = world.time
	garbage["\ref[thing]"] = world.time

/datum/daemon/garbage/DoWork()
	for(var/gref in garbage)
		var/timeout = garbage[gref]
		if(world.time < timeout+garbage_timeout)
			continue
		var/trash = locate(gref)
		if(trash && trash:gc_collect_time == timeout)
			del(trash)
		garbage[gref] = null
		garbage -= gref
		CheckSuspend()

/datum/daemon/garbage/Status()
	return "[garbage.len] queued"