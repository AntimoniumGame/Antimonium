/obj/structure/stake
	name = "horseshoes stake"
	icon = 'icons/objects/structures/stake.dmi'
	density = 0
	layer = TURF_LAYER+0.2
	hit_sound = 'sounds/effects/ding1.wav'

/obj/structure/stake/thrown_hit_by(var/atom/movable/projectile)
	if(prob(50))
		projectile.force_move(get_turf(src))
		play_local_sound(src, hit_sound, 100)
		notify_nearby("\The [projectile] clangs against the stake!")
		return TRUE
	notify_nearby("\The [projectile] narrowly misses \the [src]!")
	return FALSE
