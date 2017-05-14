/atom/proc/notify(var/message)
	to_chat(src, message)

/atom/proc/notify_nearby(var/message)
	for(var/mob/M in viewers(world.view, get_turf(src)))
		M.notify(message)

/atom/proc/dnotify(var/message)
	to_debug(src, message)
