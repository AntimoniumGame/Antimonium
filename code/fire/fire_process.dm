/atom
	var/next_burn_sound = 0
	var/fire_intensity

/atom/proc/ProcessFire()
	if(IsOnFire())
		if(istype(src, /turf) || istype(loc, /turf))
			glob.ignite_atoms |= get_turf(src)
			if(prob(FIRE_SPREAD_PROB))
				var/turf/neighbor = get_step(get_turf(src), pick(all_dirs))
				if(istype(neighbor))
					glob.ignite_atoms |= neighbor
		RadiateHeat(TEMPERATURE_WARM, 3)
		if(world.time > next_burn_sound)
			next_burn_sound = world.time + rand(120,150)
			PlayLocalSound(src, pick(glob.burn_sounds), 5, frequency = -1)
		fire_intensity = min(fire_intensity+rand(1,3),MAX_FIRE_INTENSITY)
		if(fire_intensity >= MIN_FIRE_INTENSITY_DAMAGE)
			HandleFireDamage()
	else
		fire_intensity = 0
	UpdateFireOverlay()

