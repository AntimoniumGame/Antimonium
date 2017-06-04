/client/proc/Notify(var/message)
	to_chat(src, message)

/client/proc/Dnotify(var/message)
	to_debug(src, "<span class='danger'>DEBUG:</span> [message]")

/client/proc/Anotify(var/message)
	to_debug(src, "<span class='notice'>ADMIN:</span> [message]")
