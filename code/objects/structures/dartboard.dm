/obj/item/dartboard
	name = "dartboard"
	icon = 'icons/objects/structures/dartboard.dmi'
	density = 0
	layer = TURF_LAYER+0.2
	flags = FLAG_SIMULATED | FLAG_ANCHORED

/obj/item/dartboard/Initialize()
	AlignWithWall(src)
	..()

/obj/item/dartboard/AfterDropped()
	AlignWithWall(src)
	UpdateIcon()

/obj/item/dartboard/UpdateIcon()
	if(dir)
		icon_state = "world"
	else
		icon_state = "world_flat"
	..()

/obj/item/dartboard/ThrownHitBy(var/atom/movable/projectile, var/meters_per_second = 1)

	var/obj/item/dart = projectile
	if(!istype(dart) || !dart.edged)
		return FALSE

	var/result = rand(10)
	switch(result)
		if(1)
			result = "wooden frame..."
		if(2 to 5)
			result = "outer ring."
		if(6 to 9)
			result = "inner ring!"
		else
			if(result >= 10)
				result = "bullseye!"
			else
				NotifyNearby("<span class='warning'>\The [projectile] misses \the [src] completely!</span>", MESSAGE_VISIBLE)
				return FALSE

	projectile.ForceMove(get_turf(src))
	PlayLocalSound(src, 'sounds/effects/thunk1.ogg', 100)
	NotifyNearby("<span class='warning'>\The [projectile] strikes \the [src] in the [result]</span>", MESSAGE_VISIBLE)
	return TRUE
