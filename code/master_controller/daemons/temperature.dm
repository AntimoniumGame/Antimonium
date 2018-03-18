/datum/daemon/temperature
	name = "temperature"
	delay = 10
	initial_offset = 5

/datum/daemon/temperature/DoWork()
	for(var/thing in _glob.temperature_sensitive_atoms)
		var/atom/temp = thing
		if(temp && !Deleted(temp))
			temp.ProcessTemperature()
		CHECK_SUSPEND

/datum/daemon/temperature/Status()
	return "[_glob.temperature_sensitive_atoms.len]"