/atom/New()
	..()
	if(flags & FLAG_TEMPERATURE_SENSITIVE)
		temperature_sensitive_atoms += src

/atom
	var/temperature = TEMPERATURE_ROOM

/atom/proc/get_temperature()
	return temperature

/atom/proc/equalize_temperature()
	if(!loc)
		return

	var/env_temperature = loc.get_temperature()
	if(env_temperature == temperature)
		return

	if(env_temperature < temperature)
		lose_heat(env_temperature)
	else if(env_temperature > temperature)
		gain_heat(env_temperature, loc.get_weight())

/turf/equalize_temperature()
	if(temperature > ambient_temperature())
		temperature = max(temperature - 5, ambient_temperature())
	else if(temperature < ambient_temperature())
		temperature = min(temperature + 5, ambient_temperature())

/turf/proc/ambient_temperature()
	return TEMPERATURE_ROOM

/atom/proc/process_temperature()

	set waitfor = 0
	set background = 1

	if(!(flags & FLAG_TEMPERATURE_SENSITIVE))
		temperature_sensitive_atoms -= src
		return

	equalize_temperature()
	check_temperature()

/atom/proc/check_temperature()
	return

/atom/proc/gain_heat(var/source_heat = TEMPERATURE_ROOM, var/radiator_size = 1)
	if((flags & FLAG_TEMPERATURE_SENSITIVE) && temperature < source_heat)
		temperature = min(source_heat, temperature + round(((source_heat * radiator_size) / get_weight()) * 0.1))
		return TRUE
	return FALSE

/atom/proc/lose_heat(var/source_heat = TEMPERATURE_ROOM)
	if((flags & FLAG_TEMPERATURE_SENSITIVE) && temperature > source_heat)
		temperature = max(source_heat, temperature - (min(50,max(1,round(get_weight()/3)))))
		return TRUE
	return FALSE

/atom/proc/radiate_heat(var/amount, var/distance = 1)
	. = min(TEMPERATURE_MAX, max(TEMPERATURE_ZERO, amount))
	for(var/turf/neighbor in trange(distance, src))
		neighbor.gain_heat(round(. / max(1,(get_dist(src, neighbor)*2)-1)), get_weight())
