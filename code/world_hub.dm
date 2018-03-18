/world/proc/UpdateStatus()
#ifndef TRAVIS_TEST
	if(_glob.config["hub_status"]) status =       _glob.config["hub_status"]
	if(_glob.config["hub_name"])   name =         _glob.config["hub_name"]
	if(_glob.config["hub_id"])     hub =          _glob.config["hub_id"]
	if(_glob.config["hub_pass"])   hub_password = _glob.config["hub_pass"]

	// Update player counts if necessary.
	if(status)
		var/_player_count = 0
		var/_admin_count = 0
		for(var/thing in _glob.clients)
			var/client/C = thing
			if(_glob.admins[C.ckey])
				_admin_count++
			else
				_player_count++
		status += " - <b>[_player_count]</b> player\s, <b>[_admin_count]</b> admin\s online."
#endif
