/obj/structure/millstone
	name = "millstone"
	icon = 'icons/objects/structures/millstone.dmi'
	density = 1
	icon_state = "world"
	flags = FLAG_SIMULATED | FLAG_ANCHORED
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

/obj/structure/millstone/Initialize(var/list/supplying = list())
	. = ..()
	if(!axle)
		axle = new(get_turf(src))
		axle.layer = layer + 0.1
		axle.icon = icon
		axle.icon_state = "axle"
		axle.pixel_x = pixel_x
		axle.pixel_y = pixel_x

		spawn()
			while(1)
				if(!axle) break
				animate(axle, transform = turn(matrix(), 120), time = axle_spin_period)
				sleep(axle_spin_period)
				if(!axle) break
				animate(axle, transform = turn(matrix(), 240), time = axle_spin_period)
				sleep(axle_spin_period)
				if(!axle) break
				animate(axle, transform = null, time = axle_spin_period)
				sleep(axle_spin_period)
