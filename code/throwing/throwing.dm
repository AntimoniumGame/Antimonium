/atom/movable/proc/ThrownAt(var/atom/target, var/mob/thrower)
	var/mob/owner = loc
	if(istype(owner))
		owner.DropItem(src)
	ForceMove(get_turf(src))
	PlayLocalSound(src, 'sounds/effects/whoosh1.wav', 75)
	var/vector/V = new(src, thrower, target)
	V.Initialize()
