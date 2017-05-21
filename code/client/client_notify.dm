/client/proc/Notify(var/message)
	to_chat(src, message)

/client/proc/Dnotify(var/message)
	to_debug(src, "DEBUG: [message]")

/client/proc/Anotify(var/message)
	to_debug(src, "ADMIN: [message]")
