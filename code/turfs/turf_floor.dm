/turf/floor
	icon_state = "1"

/turf/floor/New()
	icon_state = pick(icon_states(icon))
	..()

/turf/floor/stone
	name = "cobblestones"
	icon = 'icons/turfs/cobbles.dmi'

/turf/floor/dirt
	name = "dirt"
	icon = 'icons/turfs/dirt.dmi'

/turf/floor/grass
	name = "grass"
	icon = 'icons/turfs/grass.dmi'

/turf/floor/tiles
	name = "tiled floor"
	icon = 'icons/turfs/tiles.dmi'
	icon_state = "1"

/turf/floor/update_icon(var/list/supplied = list(), var/update_neighbors)

	var/list/connected_neighbors = list()
	for(var/thing in trange(1,src))
		if(thing == src)
			continue
		var/turf/neighbor = thing
		if(neighbor.density)
			continue
		if(update_neighbors)
			neighbor.update_icon()
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
		var/image/I = image('icons/images/turf_shadows.dmi', "[corner]", dir = 1<<(i-1))
		I.alpha = 80
		supplied += I
	..(supplied)
