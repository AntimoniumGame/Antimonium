/turf/proc/check_thrown_collision(var/atom/movable/thrown)
	if(density)
		if(!thrown.ethereal && !ethereal)
			return TRUE
		thrown_hit_by(thrown)
	for(var/thing in (contents - thrown))
		var/atom/movable/obstacle = thing
		if(obstacle.thrown_hit_by(thrown))
			return TRUE
	return FALSE

/atom/proc/thrown_hit_by(var/atom/movable/projectile)
	return FALSE

/obj/structure/thrown_hit_by(var/atom/movable/projectile)
	if(density)
		projectile.force_move(get_turf(src))
		play_local_sound(src, hit_sound, 100)
		notify_nearby("\The [src] has been hit by \the [projectile]!")
		return TRUE
	return FALSE

/mob/thrown_hit_by(var/atom/movable/projectile)
	if(density)
		projectile.force_move(get_turf(src))
		notify_nearby("\The [src] has been hit by \the [projectile]!")
		if(istype(projectile, /obj/item))
			var/obj/item/weapon = projectile
			play_local_sound(src, weapon.hit_sound, 75)
			resolve_physical_attack(null, weapon.weight, weapon.sharpness, weapon.contact_size, weapon)
		else
			resolve_physical_attack(null, 5, 0, 5, projectile)

		return TRUE
	return FALSE
