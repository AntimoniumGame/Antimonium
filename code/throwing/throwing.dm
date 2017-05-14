/atom/movable/proc/thrown_at(var/atom/target, var/mob/thrower)
	var/mob/owner = loc
	if(istype(owner))
		owner.drop_item(src)
	force_move(get_turf(src))
	play_local_sound(src, 'sounds/effects/whoosh1.wav', 75)
	var/vector/V = new(src, thrower, target)
	V.Initialize()
