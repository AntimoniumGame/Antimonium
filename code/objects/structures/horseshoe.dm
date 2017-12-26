/obj/structure/stake
	name = "horseshoes stake"
	icon = 'icons/objects/structures/stake.dmi'
	density = 0
	layer = TURF_LAYER+0.2
	hit_sound = 'sounds/effects/ding1.ogg'

/obj/structure/stake/ThrownHitBy(var/atom/movable/projectile)
	if(prob(75))
		projectile.ForceMove(get_turf(src))
		PlayLocalSound(src, hit_sound, 100)
		NotifyNearby("\The [projectile] clangs against the stake!", MESSAGE_AUDIBLE)
		return TRUE
	NotifyNearby("\The [projectile] narrowly misses \the [src]!", MESSAGE_VISIBLE)
	return FALSE
