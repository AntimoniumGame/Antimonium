/atom
	var/on_fire = FALSE

/atom/proc/GetFireIcon()
	var/image/I
	switch(fire_intensity)
		if(80 to 100)
			I = image('icons/images/fire.dmi', "max")
		if(60 to 80)
			I = image('icons/images/fire.dmi', "large")
		if(30 to 60)
			I = image('icons/images/fire.dmi', "mid")
	if(!I)
		I = image('icons/images/fire.dmi', "small")
	I.layer = MOB_LAYER + 0.9
	return I

/atom/UpdateIcon(var/list/supplied = list(), var/ignore_neighbors = FALSE)
	if(IsOnFire())
		var/image/I = GetFireIcon()
		if(I)
			supplied += I
	..(supplied)

/atom/proc/CanIgnite()
	return IsFlammable()

/atom/proc/HandleFireDamage()
	if(fire_intensity > 90)
		// create ashes
//		RemoveLight()
		QDel(src)

/atom/proc/Ignite(var/mob/user)
	if(CanIgnite() && !IsOnFire())
		burning_atoms |= src
		on_fire = TRUE
		UpdateIcon()
		return TRUE
	return FALSE

/atom/proc/Extinguish(var/mob/user)
	if(IsOnFire())
		fire_intensity = 0
		burning_atoms -= src
		on_fire = FALSE
		UpdateIcon()
		return TRUE
	return FALSE

/atom/proc/IsFlammable()
	return ((flags & FLAG_FLAMMABLE) && (flags & FLAG_SIMULATED))

/atom/proc/IsOnFire()
	return on_fire

// TODO: fuel and consumption
/atom/proc/StokeFire()
	if(IsOnFire() && temperature < TEMPERATURE_FURNACE)
		temperature = min(TEMPERATURE_FURNACE, temperature + rand(300,500))
		fire_intensity = max(100,fire_intensity + rand(10,20))
		if(prob(10))
			NotifyNearby("<span class='alert'>The flames of \the [src] flare up higher!</span>")
