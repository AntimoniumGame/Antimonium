/atom
	var/on_fire = FALSE
	var/last_fire_state
	var/image/fire_overlay

/atom/proc/GetFireIconState()
	if(!IsOnFire())
		return
	switch(fire_intensity)
		if(80 to MAX_FIRE_INTENSITY)
			return "max"
		if(60 to 80)
			return "large"
		if(30 to 60)
			return "mid"
		else
			return "small"

/atom/proc/UpdateFireOverlay()
	var/fstate = GetFireIconState()
	if(last_fire_state != fstate)
		last_fire_state = fstate

		overlays -= fire_overlay

		if(!isnull(fstate))
			fire_overlay = image(icon = 'icons/images/fire.dmi', icon_state = fstate, layer = EFFECTS_LAYER)
			fire_overlay.appearance_flags = RESET_COLOR
			overlays += fire_overlay
		else
			fire_overlay = null

		UpdateIcon()

/atom/proc/CanIgnite()
	return IsFlammable()

/atom/proc/HandleFireDamage()
	if(prob(min(100,fire_intensity))) TakeDamage(1, dtype = WOUND_BURN)

/atom/proc/Ignite(var/mob/user)
	if(CanIgnite() && !IsOnFire())
		_glob.burning_atoms |= src
		on_fire = TRUE
		// Light on
		UpdateFireOverlay()
		return TRUE
	return FALSE

/atom/proc/Extinguish(var/mob/user)
	if(IsOnFire())
		fire_intensity = 0
		_glob.burning_atoms -= src
		on_fire = FALSE
		ResetLights()
		UpdateFireOverlay()
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
		fire_intensity = max(MAX_FIRE_INTENSITY,fire_intensity + rand(10,20))
		if(prob(10))
			NotifyNearby("<span class='alert'>The flames of \the [src] flare up higher!</span>", MESSAGE_VISIBLE)
