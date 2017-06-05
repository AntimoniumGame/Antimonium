/obj/structure/window
	name = "window"
	default_material_path = /datum/material/stone/glass
	density = 1
	opacity = 0
	flags = FLAG_SIMULATED | FLAG_ANCHORED
	icon = 'icons/objects/structures/window.dmi'
	icon_state = "map"

/obj/structure/window/UpdateIcon(var/list/supplied = list(), var/ignore_neighbors = FALSE)
	icon_state = ""
	var/list/connected_neighbors = list()
	for(var/thing in Trange(1,src))
		var/turf/neighbor = thing
		var/found_window = FALSE
		for(var/obj/structure/window/window in neighbor.contents)
			found_window = TRUE
			if(!ignore_neighbors)
				window.UpdateIcon(ignore_neighbors = TRUE)
		if(found_window || neighbor.density)
			connected_neighbors += get_dir(src, neighbor)

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