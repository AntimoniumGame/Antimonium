/obj/structure/window
	name = "window"
	default_material_path = /datum/material/stone/glass
	density = 1
	opacity = 0
	flags = FLAG_SIMULATED | FLAG_ANCHORED
	icon = 'icons/objects/structures/window.dmi'
	icon_state = "map"
	draw_shadow_underlay = null
	max_damage = 10

	var/list/window_overlays		// overlays to join the window to other windows

/obj/structure/window/Destroyed()
	NotifyNearby("<span class='alert'>\The [src] shatters!</span>", MESSAGE_VISIBLE)
	PlayLocalSound(src, 'sounds/effects/shatter1.ogg', 100)
	new /obj/item/stack/shards(get_turf(src), _amount = rand(5,10))
	var/oldloc = loc

	// Ugly, it's so it updates the correct set of icons.
	QDel(src, "shattered")
	loc = oldloc
	UpdateIcon()
	NullLoc(src)

/obj/structure/window/UpdateIcon(var/ignore_neighbors = FALSE)
	icon_state = ""

	overlays -= window_overlays

	window_overlays = list()
	var/list/connected_neighbors = list()
	for(var/thing in Trange(1,src))
		var/turf/neighbor = thing
		var/found_window = FALSE
		for(var/obj/structure/window/window in neighbor.contents)
			if(Deleted(window))
				continue
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
		window_overlays += image(icon, "[corner]", dir = 1<<(i-1))

	overlays += window_overlays
	..()
