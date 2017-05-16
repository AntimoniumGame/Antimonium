/datum/daemon/temperature
	name = "temperature"
	delay = 10
	initial_offset = 5

/datum/daemon/temperature/do_work()
	for(var/thing in temperature_sensitive_atoms)
		var/atom/temp = thing
		if(temp && !deleted(temp))
			temp.process_temperature()
		check_suspend()

/datum/daemon/temperature/status()
	return "[temperature_sensitive_atoms.len]"