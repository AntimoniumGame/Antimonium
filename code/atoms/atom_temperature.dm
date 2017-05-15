/atom/New()
	..()
	if(flags & FLAG_TEMPERATURE_SENSITIVE)
		temperature_sensitive_atoms += src

/atom
	var/temperature

/atom/proc/get_temperature()
	if(isnull(temperature))
		temperature = TEMPERATURE_ROOM
	return temperature

/atom/proc/process_temperature()

	set waitfor = 0
	set background = 1

	if(!(flags & FLAG_TEMPERATURE_SENSITIVE))
		temperature_sensitive_atoms -= src
		return

	if(!loc)
		return

	var/env_temperature = loc.get_temperature()
	if(env_temperature < temperature)
		lose_heat(env_temperature, loc.get_weight())
	else if(env_temperature > temperature)
		gain_heat(env_temperature, loc.get_weight())

	check_temperature()

/atom/proc/check_temperature()
	return

/atom/proc/gain_heat(var/source_heat = TEMPERATURE_ROOM, var/radiator_size = 1)
	if(contents && contents.len)
		var/rad_size = max(1,round(radiator_size/contents.len))
		for(var/atom/thing in contents)
			if(thing.flags & FLAG_SIMULATED)
				thing.gain_heat(source_heat, rad_size)
	if((flags & FLAG_TEMPERATURE_SENSITIVE) && temperature < source_heat)
		temperature = min(source_heat, temperature + round(source_heat * (radiator_size/100)))

/atom/proc/lose_heat(var/source_heat = TEMPERATURE_ROOM, var/radiator_size = 1)
	if(contents && contents.len)
		var/rad_size = max(1,round(radiator_size/contents.len))
		for(var/atom/thing in contents)
			if(thing.flags & FLAG_SIMULATED)
				thing.lose_heat(source_heat, rad_size)
	if((flags & FLAG_TEMPERATURE_SENSITIVE) && temperature > source_heat)
		temperature = max(source_heat, temperature - round(source_heat * (radiator_size/100)))

/atom/proc/radiate_heat(var/amount, var/distance = 1)
	. = min(TEMPERATURE_MAX, max(TEMPERATURE_ZERO, amount))

/atom/movable/radiate_heat(var/amount, var/distance = 1)
	. = ..()
	var/turf/current_turf = get_turf(src)
	if(!istype(current_turf))
		return
	for(var/turf/neighbor in trange(distance, current_turf))
		var/falloff = max(1,(get_dist(current_turf, neighbor)*2)-1)
		for(var/thing in neighbor.contents)
			if(thing == src)
				continue
			var/atom/heating = thing
			if(heating.flags & FLAG_SIMULATED)
				heating.gain_heat(round(. / falloff), get_weight())
