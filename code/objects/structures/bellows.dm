/obj/structure/bellows
	name = "bellows"
	icon = 'icons/objects/structures/bellows.dmi'
	icon_state = "world"
	default_material_path = null
	var/in_use = FALSE

/obj/structure/bellows/ManipulatedBy(var/mob/user, var/slot)
	. = ..()
	if(!. && !in_use)
		in_use = TRUE
		flick("blow",src)
		NotifyNearby("\The [user] works \the [src]!")
		var/turf/neighbor = get_step(get_turf(src), dir)
		for(var/thing in neighbor.contents)
			var/atom/atom = thing
			if((atom.flags & FLAG_SIMULATED) && atom.IsOnFire())
				atom.StokeFire()
		sleep(15)
		icon_state = "world"
		in_use = FALSE
