/atom/New()
	..()
	if(flags & FLAG_TEMPERATURE_SENSITIVE)
		temperature_sensitive_atoms += src

/atom
	var/temperature = TEMPERATURE_ROOM

/atom/proc/GetTemperature()
	return temperature

/atom/proc/EqualizeTemperature()
	if(!loc)
		return

	var/env_temperature = loc.GetTemperature()
	if(env_temperature == temperature)
		return

	if(env_temperature < temperature)
		LoseHeat(env_temperature)
	else if(env_temperature > temperature)
		GainHeat(env_temperature, loc.get_weight())

/turf/EqualizeTemperature()
	if(temperature > AmbientTemperature())
		temperature = max(temperature - 5, AmbientTemperature())
	else if(temperature < ambient_temperature())
		temperature = min(temperature + 5, AmbientTemperature())

/turf/proc/AmbientTemperature()
	return TEMPERATURE_ROOM

/atom/proc/ProcessTemperature()

	set waitfor = 0
	set background = 1

	if(!(flags & FLAG_TEMPERATURE_SENSITIVE))
		temperature_sensitive_atoms -= src
		return

	EqualizeTemperature()
	CheckTemperature()

/atom/proc/CheckTemperature()
	return

/atom/proc/GainHeat(var/source_heat = TEMPERATURE_ROOM, var/radiator_size = 1)
	if((flags & FLAG_TEMPERATURE_SENSITIVE) && temperature < source_heat)
		temperature = min(source_heat, temperature + round(((source_heat * radiator_size) / GetWeight()) * 0.1))
		return TRUE
	return FALSE

/atom/proc/LoseHeat(var/source_heat = TEMPERATURE_ROOM)
	if((flags & FLAG_TEMPERATURE_SENSITIVE) && temperature > source_heat)
		temperature = max(source_heat, temperature - (min(50,max(1,round(GetWeight()/3)))))
		return TRUE
	return FALSE

/atom/proc/RadiateHeat(var/amount, var/distance = 1)
	. = min(TEMPERATURE_MAX, max(TEMPERATURE_ZERO, amount))
	for(var/turf/neighbor in Trange(distance, src))
		neighbor.GainHeat(round(. / max(1,(get_dist(src, neighbor)*2)-1)), GetWeight())
