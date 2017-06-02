/turf/wall
	name = "wall"
	icon_state = "map"
	icon = 'icons/turfs/_wall.dmi'
	density = 1
	opacity = 1

/turf/wall/cobble
	name = "dressed stone wall"
	icon = 'icons/turfs/cobble_wall.dmi'

/turf/wall/stone
	name = "stone wall"
	icon = 'icons/turfs/stone_wall.dmi'

/turf/wall/dirt
	name = "dirt wall"
	icon = 'icons/turfs/dirt_wall.dmi'

/turf/wall/wood
	name = "wooden wall"
	icon = 'icons/turfs/wood_wall.dmi'

/turf/wall/tiled
	name = "tiled wall"
	icon = 'icons/turfs/tile_wall.dmi'

/turf/wall/UpdateIcon(var/list/supplied = list(), var/ignore_neighbors)
	icon_state = ""
	var/list/connected_neighbors = list()
	for(var/thing in Trange(1,src))
		if(thing == src)
			continue
		var/turf/neighbor = thing
		if(!ignore_neighbors)
			neighbor.UpdateIcon(ignore_neighbors = TRUE)
		if(neighbor.density)
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
