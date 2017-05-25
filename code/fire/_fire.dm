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

/atom/proc/StokeFire()
	return //todo
