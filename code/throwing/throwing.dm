/atom/movable/proc/ThrownAt(var/atom/target, var/mob/thrower, var/throw_force = 1)
	var/mob/owner = loc
	if(istype(owner))
		owner.DropItem(src)
	ForceMove(get_turf(src))
	PlayLocalSound(src, 'sounds/effects/whoosh1.ogg', 75)
	var/vector/V = new(src, thrower, target, throw_force = throw_force)
	V.Initialize()
