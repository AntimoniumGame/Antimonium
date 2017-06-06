/obj/item/dartboard
	name = "dartboard"
	icon = 'icons/objects/structures/dartboard.dmi'
	density = 0
	layer = TURF_LAYER+0.2
	flags = FLAG_SIMULATED | FLAG_ANCHORED
	contact_size = 5
	weight = 3

/obj/item/dartboard/Initialize()
	AlignWithWall(src)
	..()

/obj/item/dartboard/AfterDropped()
	AlignWithWall(src)
	UpdateIcon()

/obj/item/dartboard/UpdateIcon(var/list/supplied)
	if(dir)
		icon_state = "world"
	else
		icon_state = "world_flat"
	..(supplied)

/obj/item/dartboard/ThrownHitBy(var/atom/movable/projectile)

	var/obj/item/dart = projectile
	if(!istype(dart) || !dart.sharpness)
		return FALSE

	var/result = rand(10) + dart.contact_size
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
				NotifyNearby("\The [projectile] misses \the [src] completely!")
				return FALSE

	projectile.ForceMove(get_turf(src))
	PlayLocalSound(src, 'sounds/effects/thunk1.ogg', 100)
	NotifyNearby("<span class='warning'>\The [projectile] strikes \the [src] in the [result]</span>")
	return TRUE
