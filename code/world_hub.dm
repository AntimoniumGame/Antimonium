/world/proc/UpdateStatus()
#ifndef TRAVIS_TEST
	if(glob.config["hub_status"]) status =       glob.config["hub_status"]
	if(glob.config["hub_name"])   name =         glob.config["hub_name"]
	if(glob.config["hub_id"])     hub =          glob.config["hub_id"]
	if(glob.config["hub_pass"])   hub_password = glob.config["hub_pass"]

	// Update player counts if necessary.
	if(status)
		var/_player_count = 0
		var/_admin_count = 0
		for(var/thing in glob.clients)
			var/client/C = thing
			if(glob.admins[C.ckey])
				_admin_count++
			else
				_player_count++
		status += " - <b>[_player_count]</b> player\s, <b>[_admin_count]</b> admin\s online."
#endif
