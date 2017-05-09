/client/proc/saveData()
	var/savefile = new/savefile("saves/[ckey]")
	savefile["key_binds"] << key_binds

/client/proc/loadData()
	var/loadfile = new/savefile("saves/[ckey]")
	loadfile["key_binds"] >> key_binds

/client/Del()
	saveData()
	. = ..()
