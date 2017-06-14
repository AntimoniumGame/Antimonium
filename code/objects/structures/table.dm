/obj/structure/table
	name = "table"
	icon = 'icons/objects/structures/table.dmi'
	icon_state = "map"
	weight = 50
	default_material_path = /datum/material/wood
	flags = FLAG_SIMULATED | FLAG_FLAT_SURFACE

/obj/structure/table/shelf
	name = "shelf"
	icon = 'icons/objects/structures/shelf.dmi'
	icon_state = "map"
	density = 0
	weight = 30
	flags = FLAG_SIMULATED | FLAG_ANCHORED | FLAG_FLAT_SURFACE

/obj/structure/table/shelf/north
	dir = NORTH

/obj/structure/table/shelf/south
	dir = SOUTH

/obj/structure/table/shelf/east
	dir = EAST

/obj/structure/table/shelf/west
	dir = WEST

/obj/structure/table/shelf/Initialize()
	..()
	AlignWithWall(src)

/obj/structure/table/bench
	name = "workbench"
	icon = 'icons/objects/structures/table_multi.dmi'
	draw_shadow_underlay = null
	flags = FLAG_SIMULATED | FLAG_ANCHORED | FLAG_FLAT_SURFACE
	var/list/bench_overlays // the overlays that make it look like a multi-tile bench

/obj/structure/table/bench/UpdateIcon()
	icon_state = ""

	overlays -= bench_overlays

	bench_overlays = list()
	var/list/connected_neighbors = list()

	for(var/thing in Trange(1,src))
		if(thing == loc)
			continue
		var/turf/neighbor = thing
		if(locate(/obj/structure/table/bench) in neighbor)
			connected_neighbors += get_dir(loc, neighbor)
	for(var/i = 1 to 4)
		var/cdir = corner_dirs[i]
		var/corner = 0
		if(cdir in connected_neighbors)
			corner |= 2
		if(turn(cdir,45) in connected_neighbors)
			corner |= 1
		if(turn(cdir,-45) in connected_neighbors)
			corner |= 4
		bench_overlays += image(icon, "[corner]", dir = 1<<(i-1))

	overlays += bench_overlays
	..()
