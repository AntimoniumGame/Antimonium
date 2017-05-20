/atom/New()
	..()
	if(flags & FLAG_TEMPERATURE_SENSITIVE)
		temperature_sensitive_atoms += src

/atom
	var/temperature = TEMPERATURE_ROOM

/atom/proc/GetTemperature()
	return temperature

/atom/proc/ProcessTemperature()

	set waitfor = 0
	set background = 1

	if(!(flags & FLAG_TEMPERATURE_SENSITIVE))
		temperature_sensitive_atoms -= src
		return

	if(!loc)
		return

	var/env_temperature = loc.GetTemperature()
	if(env_temperature < temperature)
		LoseHeat(env_temperature, loc.GetWeight())
	else if(env_temperature > temperature)
		GainHeat(env_temperature, loc.GetWeight())

	CheckTemperature()

/atom/proc/CheckTemperature()
	return

/atom/proc/GainHeat(var/source_heat = TEMPERATURE_ROOM, var/radiator_size = 1)
	if(contents && contents.len)
		var/rad_size = max(1,round(radiator_size/contents.len))
		for(var/atom/thing in contents)
			if(thing.flags & FLAG_SIMULATED)
				thing.GainHeat(source_heat, rad_size)
	if((flags & FLAG_TEMPERATURE_SENSITIVE) && temperature < source_heat)
		temperature = min(source_heat, temperature + round(source_heat * (radiator_size/100)))

/atom/proc/LoseHeat(var/source_heat = TEMPERATURE_ROOM, var/radiator_size = 1)
	if(contents && contents.len)
		var/rad_size = max(1,round(radiator_size/contents.len))
		for(var/atom/thing in contents)
			if(thing.flags & FLAG_SIMULATED)
				thing.LoseHeat(source_heat, rad_size)
	if((flags & FLAG_TEMPERATURE_SENSITIVE) && temperature > source_heat)
		temperature = max(source_heat, temperature - round(source_heat * (radiator_size/100)))

/atom/proc/RadiateHeat(var/amount, var/distance = 1)
	. = min(TEMPERATURE_MAX, max(TEMPERATURE_ZERO, amount))

/atom/movable/RadiateHeat(var/amount, var/distance = 1)
	. = ..()
	var/turf/current_turf = get_turf(src)
	if(!istype(current_turf))
		return
	for(var/turf/neighbor in Trange(distance, current_turf))
		var/falloff = max(1,(get_dist(current_turf, neighbor)*2)-1)
		for(var/thing in neighbor.contents)
			if(thing == src)
				continue
			var/atom/heating = thing
			if(heating.flags & FLAG_SIMULATED)
				heating.GainHeat(round(. / falloff), GetWeight())
