/atom
	var/on_fire = FALSE
	var/last_fire_state
	var/image/fire_overlay

/atom/proc/GetFireIconState()
	if(!IsOnFire())
		return
	switch(fire_intensity)
		if(80 to 100)
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
		if(fire_overlay)
			overlays -= fire_overlay
		if(!isnull(fstate))
			fire_overlay = image(icon = 'icons/images/fire.dmi', icon_state = fstate)
			fire_overlay.layer = MOB_LAYER + 0.9
			overlays += fire_overlay
		else
			fire_overlay = null

/atom/proc/CanIgnite()
	return IsFlammable()

/atom/proc/HandleFireDamage()
	if(fire_intensity > 90)
		// create ashes
		KillLight()
		QDel(src)

/atom/proc/Ignite(var/mob/user)
	if(CanIgnite() && !IsOnFire())
		burning_atoms |= src
		on_fire = TRUE
		SetFireLight()
		UpdateFireOverlay()
		return TRUE
	return FALSE

/atom/proc/Extinguish(var/mob/user)
	if(IsOnFire())
		fire_intensity = 0
		burning_atoms -= src
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
		fire_intensity = max(100,fire_intensity + rand(10,20))
		if(prob(10))
			NotifyNearby("<span class='alert'>The flames of \the [src] flare up higher!</span>")
