/obj/structure/still
	name = "still"
	flags = FLAG_SIMULATED | FLAG_ANCHORED
	icon = 'icons/objects/structures/still.dmi'
	default_material_path = /datum/material/metal/copper
	pixel_x = -8
	pixel_y = 8

/obj/structure/still/horizontal
	dir = SOUTH
	pixel_x = 8
	pixel_y = -8

/obj/structure/still/SetDir(var/newdir)
	. = ..(newdir)
	switch(dir)
		if(NORTH, SOUTH)
			bound_width = 64
			bound_height = 32
			pixel_x = 8
			pixel_y = -8
		if(EAST, WEST)
			bound_width = 32
			bound_height = 64
			pixel_x = -8
			pixel_y = 8
