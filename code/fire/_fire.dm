/atom
	var/on_fire = FALSE

/atom/proc/GetFireIcon()
	return image('icons/images/fire.dmi', "mid")

/atom/UpdateIcon(var/list/supplied = list())
	if(IsOnFire())
		var/image/I = GetFireIcon()
		if(I)
			supplied += I
	..(supplied)

/atom/proc/CanIgnite()
	return IsFlammable()

/atom/proc/Ignite(var/mob/user)
	if(CanIgnite() && !IsOnFire())
		burning_atoms |= src
		on_fire = TRUE
		SetFireLight()
		UpdateIcon()
		return TRUE
	return FALSE

/atom/proc/Extinguish(var/mob/user)
	if(IsOnFire())
		burning_atoms -= src
		on_fire = FALSE
		ResetLights()
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
		if(prob(10))
			NotifyNearby("The flames of \the [src] flare up higher!")
