/turf/proc/CheckThrownCollision(var/atom/movable/thrown, var/meters_per_second = 1)
	if(density)
		if(!(thrown.flags & FLAG_ETHEREAL) && !(flags & FLAG_ETHEREAL))
			return TRUE
		ThrownHitBy(thrown, meters_per_second)
	for(var/thing in (contents - thrown))
		var/atom/movable/obstacle = thing
		if(istype(obstacle) && obstacle.ThrownHitBy(thrown, meters_per_second))
			return TRUE
	return FALSE

/atom/proc/ThrownHitBy(var/atom/movable/projectile, var/meters_per_second = 1)
	return FALSE

/obj/structure/ThrownHitBy(var/atom/movable/projectile, var/meters_per_second = 1)
	if(density && !(flags & FLAG_FLAT_SURFACE))
		ThingPlacedOn(null, projectile, precise_placement = FALSE)
		PlayLocalSound(src, hit_sound, 100)
		NotifyNearby("<span class='danger'><b>\The [src] has been hit by \the [projectile]!</b></span>", MESSAGE_VISIBLE)
		var/obj/item/prop = projectile
		if(istype(prop))
			TakeDamage(prop.GetMass() * meters_per_second, null)
		return TRUE
	return FALSE

/mob/ThrownHitBy(var/atom/movable/projectile, var/meters_per_second = 1)
	if(density)
		projectile.ForceMove(get_turf(src))
		NotifyNearby("<span class='danger'><b>\The [src] has been hit by \the [projectile]!</b></span>", MESSAGE_VISIBLE)
		if(istype(projectile, /obj/item))
			var/obj/item/weapon = projectile
			PlayLocalSound(src, weapon.hit_sound, 75)
			HandleImpact(null, weapon, meters_per_second)
			return TRUE
	return FALSE
