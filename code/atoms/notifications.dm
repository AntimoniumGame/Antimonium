/atom/proc/Notify(var/message, var/message_type)
	to_chat(src, message)

/atom/proc/NotifyNearby(var/message, var/message_type)
	for(var/mob/M in viewers(world.view, get_turf(src)))
		M.Notify(message, message_type)

/atom/proc/Dnotify(var/message)
	to_debug(src, message)
