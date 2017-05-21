/atom/proc/Notify(var/message)
	to_chat(src, message)

/atom/proc/NotifyNearby(var/message)
	for(var/mob/M in viewers(world.view, get_turf(src)))
		M.Notify(message)

/atom/proc/Dnotify(var/message)
	to_debug(src, message)
