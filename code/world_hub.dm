/world/proc/UpdateStatus()
#ifndef TRAVIS_TEST
	if(config["hub_status"]) status =       config["hub_status"]
	if(config["hub_name"])   name =         config["hub_name"]
	if(config["hub_id"])     hub =          config["hub_id"]
	if(config["hub_pass"])   hub_password = config["hub_pass"]

	// Update player counts if necessary.
	if(status)
		var/_player_count = 0
		var/_admin_count = 0
		for(var/thing in clients)
			var/client/C = thing
			if(admins[C.ckey])
				_admin_count++
			else
				_player_count++
		status += " - <b>[_player_count]</b> player\s, <b>[_admin_count]</b> admin\s online."
#endif
