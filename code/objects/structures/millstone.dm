/obj/structure/millstone
	name = "millstone"
	icon = 'icons/objects/structures/millstone.dmi'
	density = 0
	icon_state = "world"
	flags = FLAG_SIMULATED | FLAG_ANCHORED | FLAG_FLAT_SURFACE
	layer = TURF_LAYER+0.1
	pixel_x = -32
	pixel_y = -32
	bound_x = -32
	bound_y = -32
	bound_width = 96
	bound_height = 96
	weight = 1000
	default_material_path = /datum/material/stone

	var/obj/effect/axle
	var/axle_spin_period = 10
	var/current_axle_dir = 0

/obj/structure/millstone/ThingPlacedOn(var/mob/user, var/obj/item/prop, var/precise_placement = TRUE)
	var/turf/current = get_turf(src)
	current = get_step(current, get_dir(src, get_turf(prop)))
	prop.ForceMove(current)
	if(user)
		user.NotifyNearby("\The [user] places \the [prop] into \the [src].")

/obj/structure/millstone/Initialize()
	. = ..()

	axle = new(get_turf(src))
	axle.layer = layer
	axle.icon = icon
	axle.icon_state = "axle"
	axle.pixel_x = pixel_x
	axle.pixel_y = pixel_x

	spawn()
		while(axle)
			current_axle_dir += 45
			if(current_axle_dir >= 360)
				current_axle_dir = 0
			animate(axle, transform = turn(matrix(), current_axle_dir), time = axle_spin_period)
			var/turf/grinding = get_step(get_turf(src), turn(NORTH, -(current_axle_dir)))
			if(istype(grinding))
				for(var/thing in grinding.contents)
					var/atom/atom = thing
					if(atom.flags & FLAG_SIMULATED)
						atom.Grind()
			sleep(axle_spin_period)

/obj/structure/millstone/Destroy()
	if(axle)
		QDel(axle, "parent destroyed")
		axle = null
	. = ..()