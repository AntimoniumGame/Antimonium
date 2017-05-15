/client/proc/notify(var/message)
	to_chat(src, message)

/client/proc/dnotify(var/message)
	to_debug(src, "DEBUG: [message]")

/client/proc/anotify(var/message)
	to_debug(src, "ADMIN: [message]")
