/mob
	temperature = TEMPERATURE_BLOOD
	var/body_temperature =  TEMPERATURE_BLOOD
	var/heat_suffer_point = TEMPERATURE_NEVER_HOT
	var/heat_harm_point =   TEMPERATURE_NEVER_HOT
	var/cold_suffer_point = TEMPERATURE_NEVER_COLD
	var/cold_harm_point =   TEMPERATURE_NEVER_COLD
	var/next_temp_warning = 0

/mob/CheckTemperature()
	RadiateHeat(TEMPERATURE_BLOOD)
	if(body_temperature < temperature)
		body_temperature = min(temperature, round(body_temperature + ((temperature - body_temperature)/(GetMass()*0.1))))
	else if(body_temperature > temperature)
		body_temperature = max(temperature, round(body_temperature - ((body_temperature - temperature)/(GetMass()*0.1))))

	if(body_temperature < TEMPERATURE_BLOOD)
		body_temperature = min(TEMPERATURE_BLOOD, round(body_temperature + ((TEMPERATURE_BLOOD - body_temperature)/(GetMass()*0.01))))

	if(world.time >= next_temp_warning)
		next_temp_warning = world.time + rand(100,200)
		if(body_temperature > heat_harm_point)
			Notify("<span class='danger'>Your very life is sapped by the terrible heat surrounding you.</span>")
		else if(body_temperature > heat_suffer_point)
			Notify("<span class='warning'>Sweat beads your brow in the oppressive heat.</span>")
		else if(body_temperature < cold_harm_point)
			Notify("<span class='danger'>A curious lassitude settles over you as the freezing cold eats at your mind.</span>")
		else if(body_temperature < cold_suffer_point)
			Notify("<span class='warning'>You shiver in the cold, teeth chattering.</span>")

/mob/Ignite()
	var/on_fire = IsOnFire()
	. = ..()
	if(!on_fire && IsOnFire())
		Notify("<span class='danger'>You burst into flames!</span>")

/mob/ProcessFire()
	. = ..()
	if(IsOnFire())
		if(prob(20))
			Notify("<span class='danger'>You are scorched by the hungry flames!</span>")
		ResolveBurn(max(1,round(fire_intensity*0.25)))
