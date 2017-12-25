/obj/structure/carpet
	name = "carpet"
	icon = 'icons/objects/structures/carpet.dmi'
	icon_state = "single_tile"
	flags = FLAG_SIMULATED | FLAG_ANCHORED
	layer = TURF_LAYER+0.99
	density = 0
	default_material_path = /datum/material/cloth

	var/x_size = 2
	var/y_size = 2
	var/list/carpet_overlays

/obj/structure/carpet/ManipulatedBy(var/mob/user)
	NotifyNearby("\The [user] rotates \the [src].", MESSAGE_VISIBLE)
	Rotate()

/obj/structure/carpet/proc/Rotate()
	var/old_x_size = x_size
	x_size = y_size
	y_size = old_x_size
	UpdateIcon()

/obj/structure/carpet/mid
	x_size = 3
	y_size = 3

/obj/structure/carpet/long
	x_size = 2
	y_size = 5

/obj/structure/carpet/large
	x_size = 3
	y_size = 3

/obj/structure/carpet/UpdateIcon()

	bound_width = 32 * x_size
	bound_height = 32 * y_size

	overlays -= carpet_overlays
	carpet_overlays = list()

	for(var/tx = 1 to x_size)
		for(var/ty = 1 to y_size)
			var/cell_icon_state
			if(tx == 1)
				if(ty == 1)
					cell_icon_state = "sw"
				else if(ty == y_size)
					cell_icon_state = "nw"
				else
					cell_icon_state = "w"
			else if(tx == x_size)
				if(ty == 1)
					cell_icon_state = "se"
				else if(ty == y_size)
					cell_icon_state = "ne"
				else
					cell_icon_state = "e"
			else if(ty == 1)
				cell_icon_state = "s"
			else if(ty == y_size)
				cell_icon_state = "n"
			else
				cell_icon_state = "inner"
			var/image/cell = image(icon, cell_icon_state)
			cell.pixel_x = (tx-1)*32
			cell.pixel_y = (ty-1)*32
			carpet_overlays += cell
	overlays += carpet_overlays

	UpdateDamageOverlay()
