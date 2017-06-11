/obj/structure/bench
	name = "bench"
	icon = 'icons/objects/structures/bench.dmi'
	density = 0
	icon_state = "map"
	weight = 10
	default_material_path = /datum/material/wood
	flags = FLAG_SIMULATED | FLAG_ANCHORED | FLAG_FLAT_SURFACE | FLAG_SEATING
	draw_shadow_underlay = null

/obj/structure/bench/UpdateIcon()
	OrientToNeighbors()
	..()

/obj/structure/bench/Initialize()
	..()
	UpdateIcon()

/obj/structure/bench/proc/OrientToNeighbors()
	var/connect_left
	var/connect_right
	var/turf/current_turf = loc
	if(istype(current_turf))
		var/turf/neighbor = get_step(current_turf, turn(dir, 90))
		if(istype(neighbor))
			for(var/obj/structure/bench/other_bench in neighbor)
				if(other_bench.dir == dir)
					connect_left = TRUE
					break
		neighbor = get_step(current_turf, turn(dir, -90))
		if(istype(neighbor))
			for(var/obj/structure/bench/other_bench in neighbor)
				if(other_bench.dir == dir)
					connect_right = TRUE
					break
	if(connect_left && connect_right)
		icon_state = "left_to_right"
	else if(connect_left)
		icon_state = "to_left"
	else if(connect_right)
		icon_state = "to_right"
	else
		icon_state = "map"
