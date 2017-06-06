/obj/structure/window
	name = "window"
	default_material_path = /datum/material/stone/glass
	density = 1
	opacity = 0
	flags = FLAG_SIMULATED | FLAG_ANCHORED
	icon = 'icons/objects/structures/window.dmi'
	icon_state = "map"
	draw_shadow_underlay = null

/obj/structure/window/AttackedBy(var/mob/user, var/obj/item/prop)
	if(prop.GetWeight() < 3)
		user.NotifyNearby("<span class='warning'>\The [user] bangs \the [prop] against \the [src].</span>")
	else
		user.NotifyNearby("<span class='alert'>\The [user] shatters \the [src] with \the [prop]!</span>")
		Shatter()

/obj/structure/window/ThrownHitBy(var/atom/movable/projectile)
	. = ..()
	if(projectile.GetWeight() >= 3)
		Shatter()
		return FALSE

/obj/structure/window/proc/Shatter()
	NotifyNearby("<span class='alert'>\The [src] shatters!</span>")
	PlayLocalSound(src, 'sounds/effects/shatter1.ogg', 100)
	new /obj/item/stack/shards(get_turf(src), _amount = rand(5,10))
	var/oldloc = loc

	// Ugly, it's so it updates the correct set of icons.
	QDel(src)
	loc = oldloc
	UpdateIcon()
	NullLoc(src)

/obj/structure/window/UpdateIcon(var/list/supplied = list(), var/ignore_neighbors = FALSE)
	icon_state = ""
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
		supplied += image(icon, "[corner]", dir = 1<<(i-1))
	..(supplied)