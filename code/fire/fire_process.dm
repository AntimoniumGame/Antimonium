var/list/burn_sounds = list('sounds/effects/fire1.ogg','sounds/effects/fire2.ogg','sounds/effects/fire3.ogg')

/atom
	var/next_burn_sound = 0

/atom/proc/ProcessFire()

	if(!IsOnFire())
		return

	if(istype(loc, /turf))
		ignite_atoms |= loc
		if(prob(FIRE_SPREAD_PROB))
			var/turf/neighbor = get_step(loc, pick(all_dirs))
			if(istype(neighbor))
				ignite_atoms |= neighbor

	RadiateHeat(TEMPERATURE_WARM, 3)

	if(world.time > next_burn_sound)
		next_burn_sound = world.time + rand(120,150)
		PlayLocalSound(src, pick(burn_sounds), 5, frequency = -1)
