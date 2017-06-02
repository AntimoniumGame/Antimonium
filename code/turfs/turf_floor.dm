/turf/floor/
	icon_state = "1"
	var/diggable
	var/has_edges
	var/base_states = 1

/turf/floor/Initialize()
	if(base_states > 1)
		icon_state = "[rand(1,base_states)]"
	..()

/turf/floor/UpdateIcon(var/list/supplied = list(), var/update_neighbors)

	var/list/blend_edges = list()
	var/list/shadow_edges = list()
	var/list/blend_dirs = list()

	for(var/thing in Trange(1,src))
		if(thing == src)
			continue
		var/turf/neighbor = thing

		var/use_dir = get_dir(src, neighbor)
		if(!isnull(neighbor.edge_blend_layer) && (isnull(edge_blend_layer) || edge_blend_layer < neighbor.edge_blend_layer))
			blend_dirs["[use_dir]"] = list(neighbor.icon, neighbor.edge_blend_layer)
		if(has_edges && neighbor.icon == icon)
			blend_edges += use_dir
		if(!neighbor.density)
			shadow_edges += use_dir
		if(update_neighbors)
			neighbor.UpdateIcon()

	if(blend_dirs.len)
		for(var/blend_dir in blend_dirs)
			var/list/blend_data = blend_dirs[blend_dir]
			var/image/I = image(blend_data[1], "edges", dir = text2num(blend_dir))
			I.layer = layer + blend_data[2]
			supplied += I

	if(has_edges)
		for(var/i = 1 to 4)
			var/cdir = corner_dirs[i]
			var/corner = 0
			if(cdir in blend_edges)
				corner |= 2
			if(turn(cdir,45) in blend_edges)
				corner |= 1
			if(turn(cdir,-45) in blend_edges)
				corner |= 4
			supplied += image(icon, "[corner]", dir = 1<<(i-1))

	for(var/i = 1 to 4)
		var/cdir = corner_dirs[i]
		var/corner = 0
		if(cdir in shadow_edges)
			corner |= 2
		if(turn(cdir,45) in shadow_edges)
			corner |= 1
		if(turn(cdir,-45) in shadow_edges)
			corner |= 4
		var/image/I = image('icons/images/turf_shadows.dmi', "[corner]", dir = 1<<(i-1))
		I.alpha = 80
		supplied += I

	..(supplied)

/turf/floor/AttackedBy(var/mob/user, var/obj/item/prop)
	if(diggable && istype(prop, /obj/item/weapon/shovel))
		DigEarthworks(user)
		return TRUE
	. = ..()

/turf/floor/ManipulatedBy(var/mob/user, var/slot)
	if(diggable && user.IsDigger())
		DigEarthworks(user, slot, check_digger = TRUE)
		return TRUE
	. = ..()

/turf/floor/proc/DigEarthworks(var/mob/user, var/slot, var/check_digger = FALSE)

	if(slot && !user.CanUseInvSlot(slot))
		return FALSE

	if(locate(/obj/structure/earthworks) in src)
		user.Notify("There are already earthworks here. You will need to fill them in before digging.")
		return TRUE

	if(user.intent.selecting == INTENT_HELP && (!check_digger || user.IsDigger(TRUE)))
		user.NotifyNearby("\The [user] carefully tills the soil into a farm.")
		new /obj/structure/earthworks/farm(src)
	else
		user.NotifyNearby("\The [user] digs a long, deep pit.")
		new /obj/structure/earthworks/pit(src)

/turf/floor/carpet
	name = "carpet"
	icon = 'icons/turfs/carpet_floor.dmi'
	icon_state = "base"
	has_edges = TRUE

/turf/floor/water
	name = "water"
	icon = 'icons/turfs/water_floor.dmi'

/turf/floor/wood
	name = "wooden floor"
	icon = 'icons/turfs/wood_floor.dmi'
	base_states = 3

/turf/floor/cobble
	name = "cobblestones"
	icon = 'icons/turfs/cobble_floor.dmi'
	base_states = 3
	edge_blend_layer = 0.2

/turf/floor/stone
	name = "stone floor"
	icon = 'icons/turfs/stone_floor.dmi'
	base_states = 1
	edge_blend_layer = 0.1

/turf/floor/dirt
	name = "dirt"
	icon = 'icons/turfs/dirt_floor.dmi'
	diggable = TRUE
	edge_blend_layer = 0.4
	base_states = 4

/turf/floor/grass
	name = "grass"
	icon = 'icons/turfs/grass_floor.dmi'
	diggable = TRUE
	edge_blend_layer = 0.3

/turf/floor/tiles
	name = "tiled floor"
	icon = 'icons/turfs/tile_floor.dmi'
	icon_state = "1"

/client/verb/force_turf_refresh()
	for(var/turf/turf in world)
		turf.UpdateIcon(list(), TRUE)

