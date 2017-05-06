/atom/proc/notify(var/message)
		src << message

/atom/proc/notify_nearby(var/message)
	for(var/mob/M in range(get_turf(src),world.view))
		M.notify(message)
