/datum/daemon/temperature
	name = "temperature"
	delay = 10
	initial_offset = 5

/datum/daemon/temperature/DoWork()
	for(var/thing in temperature_sensitive_atoms)
		var/atom/temp = thing
		if(temp && !Deleted(temp))
			temp.ProcessTemperature()
		CheckSuspend()

/datum/daemon/temperature/Status()
	return "[temperature_sensitive_atoms.len]"