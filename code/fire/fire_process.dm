var/list/burn_sounds = list('sounds/effects/fire1.ogg','sounds/effects/fire2.ogg','sounds/effects/fire3.ogg')

/atom
	var/next_burn_sound = 0
	var/fire_intensity

/atom/proc/ProcessFire()

	if(IsOnFire())
		if(istype(src, /turf) || istype(loc, /turf))
			ignite_atoms |= get_turf(src)
			if(prob(FIRE_SPREAD_PROB))
				var/turf/neighbor = get_step(get_turf(src), pick(all_dirs))
				if(istype(neighbor))
					ignite_atoms |= neighbor
		RadiateHeat(TEMPERATURE_WARM, 3)
		if(world.time > next_burn_sound)
			next_burn_sound = world.time + rand(120,150)
			PlayLocalSound(src, pick(burn_sounds), 5, frequency = -1)
		fire_intensity = min(fire_intensity+rand(1,3),100)
		if(fire_intensity >= 70)
			HandleFireDamage()
	else
		fire_intensity = 0
	UpdateIcon()
