/turf/proc/CheckThrownCollision(var/atom/movable/thrown)
	if(density)
		if(!(thrown.flags & FLAG_ETHEREAL) && !(flags & FLAG_ETHEREAL))
			return TRUE
		ThrownHitBy(thrown)
	for(var/thing in (contents - thrown))
		var/atom/movable/obstacle = thing
		if(obstacle.ThrownHitBy(thrown))
			return TRUE
	return FALSE

/atom/proc/ThrownHitBy(var/atom/movable/projectile)
	return FALSE

/obj/structure/ThrownHitBy(var/atom/movable/projectile)
	if(density && !(flags & FLAG_FLAT_SURFACE))
		ThingPlacedOn(null, projectile, precise_placement = FALSE)
		PlayLocalSound(src, hit_sound, 100)
		NotifyNearby("<span class='danger'><b>\The [src] has been hit by \the [projectile]!</b></span>", MESSAGE_VISIBLE)
		var/obj/item/prop = projectile
		if(istype(prop))
			TakeDamage(prop.weight * prop.contact_size, null)
		return TRUE
	return FALSE

/mob/ThrownHitBy(var/atom/movable/projectile)
	if(density)
		projectile.ForceMove(get_turf(src))
		NotifyNearby("<span class='danger'><b>\The [src] has been hit by \the [projectile]!</b></span>", MESSAGE_VISIBLE)
		if(istype(projectile, /obj/item))
			var/obj/item/weapon = projectile
			PlayLocalSound(src, weapon.hit_sound, 75)
			ResolvePhysicalAttack(null, weapon.weight, weapon.sharpness, weapon.contact_size, weapon)
		else
			ResolvePhysicalAttack(null, 5, 0, 5, projectile)

		return TRUE
	return FALSE
