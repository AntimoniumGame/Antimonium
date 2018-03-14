var/datum/daemon/garbage/gc
/datum/var/gc_collect_time = 0

/proc/Deleted(var/atom/A)
	return (!istype(A) || (A.gc_collect_time != 0 && !isnull(A.gc_collect_time)))

/datum/proc/Destroy()
	return 1

/atom/Destroy()
	if(contents)
		for(var/thing in contents)
			QDel(thing, "atom destroyed")
	return 1

/atom/movable/Destroy()
	. = ..()
	loc = null

/image/Destroy()
	del(src)

// placeholder for later
/proc/QDel(var/thing, var/reason)
	/*
	if(reason)
		Dnotify("GC: collected \ref[thing] ([thing]) for '[reason]'.")
	else
		Dnotify("GC: collected \ref[thing] ([thing]).")
	*/
	gc.Collect(thing)

/datum/daemon/garbage
	name = "garbage collector"
	delay = 50
	var/garbage_timeout = 200
	var/list/garbage = list()

/datum/daemon/garbage/New()
	if(gc)
		garbage = gc.garbage
		QDel(gc, "gc replacement")
	gc = src

/datum/daemon/garbage/proc/Collect(var/thing)
	if(!thing || !thing:Destroy())
		return
	del(thing)
	//thing:gc_collect_time = world.time
	//garbage |= "\ref[thing]"

/datum/daemon/garbage/DoWork()
	var/gindex = 1
	while(garbage.len && gindex < garbage.len)
		gindex++
		var/trash = locate(garbage[gindex])
		if(!trash || trash:gc_collect_time > world.time + garbage_timeout)
			continue
		MassDnotify("GC: \ref[trash] ([trash]) failed to qdel in time and is being deleted.")
		garbage -= trash
		del(trash)
		CHECK_SUSPEND

/datum/daemon/garbage/Status()
	return "[garbage.len] queued"