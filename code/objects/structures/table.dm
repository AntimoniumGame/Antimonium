/obj/structure/table
	name = "table"
	icon = 'icons/objects/structures/table.dmi'
	icon_state = "wooden_table"
	weight = 50
	default_material_path = /datum/material/wood
	flags = FLAG_SIMULATED | FLAG_ANCHORED | FLAG_FLAT_SURFACE

/obj/structure/table/bench
	name = "workbench"
	icon = 'icons/objects/structures/table_multi.dmi'
	icon_state = "map"

/obj/structure/table/bench/UpdateIcon(var/list/supplied = list())
	icon_state = ""
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
		supplied += image(icon, "[corner]", dir = 1<<(i-1))
	..(supplied)
