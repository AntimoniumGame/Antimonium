/mob
	temperature = TEMPERATURE_BLOOD

	var/body_temperature =  TEMPERATURE_BLOOD
	var/heat_suffer_point = TEMPERATURE_NEVER_HOT
	var/heat_harm_point =   TEMPERATURE_NEVER_HOT
	var/cold_suffer_point = TEMPERATURE_NEVER_COLD
	var/cold_harm_point =   TEMPERATURE_NEVER_COLD
	var/next_temp_warning = 0

/mob/New()
	if(heat_suffer_point != TEMPERATURE_NEVER_HOT || \
	 heat_harm_point != TEMPERATURE_NEVER_HOT || \
	 cold_suffer_point != TEMPERATURE_NEVER_COLD || \
	 cold_harm_point != TEMPERATURE_NEVER_COLD)
		flags |= FLAG_TEMPERATURE_SENSITIVE
	..()

/mob/CheckTemperature()

	RadiateHeat(TEMPERATURE_BLOOD)

	if(body_temperature < temperature)
		body_temperature = min(temperature, round(body_temperature + ((temperature - body_temperature)/(GetWeight()*0.1))))
	else if(body_temperature > temperature)
		body_temperature = max(temperature, round(body_temperature - ((body_temperature - temperature)/(GetWeight()*0.1))))

	if(body_temperature < TEMPERATURE_BLOOD)
		body_temperature = min(TEMPERATURE_BLOOD, round(body_temperature + ((TEMPERATURE_BLOOD - body_temperature)/(GetWeight()*0.01))))

	if(world.time >= next_temp_warning)
		next_temp_warning = world.time + rand(100,200)
		if(body_temperature > heat_harm_point)
			Notify("Your very life is sapped by the terrible heat surrounding you.")
		else if(body_temperature > heat_suffer_point)
			Notify("Sweat beads your brow in the oppressive heat.")
		else if(body_temperature < cold_harm_point)
			Notify("A curious lassitude settles over you as the freezing cold eats at your mind.")
		else if(body_temperature < cold_suffer_point)
			Notify("You shiver in the cold, teeth chattering.")

