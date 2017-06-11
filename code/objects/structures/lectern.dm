/obj/structure/lectern
	name = "lectern"
	icon = 'icons/objects/structures/lectern.dmi'
	icon_state = "lectern"
	density = 0
	open = TRUE
	can_open = FALSE
	default_material_path = /datum/material/wood
	flags = FLAG_SIMULATED
	dir = NORTH
	pixel_x = 0
	pixel_y = 16
	var/filled

// Placeholder.
/obj/structure/lectern/New()
	if(prob(60))
		filled = pick(list("scroll","book","paper"))
	..()
// End placeholder.

/obj/structure/lectern/UpdateIcon()
	..()
	if(filled) overlays += filled

/obj/structure/lectern/ToggleOpen()
	return

/obj/structure/lectern/SetDir(var/newdir)
	..(newdir)
	switch(dir)
		if(NORTH)
			pixel_x = 0
			pixel_y = 16
		if(SOUTH)
			pixel_x = 0
			pixel_y = -16
		if(EAST)
			pixel_x = 16
			pixel_y = 0
		if(WEST)
			pixel_x = -16
			pixel_y = 0

// Mapping premades.
/obj/structure/lectern/south
	dir = SOUTH
	pixel_x = 0
	pixel_y = -16

/obj/structure/lectern/east
	dir = EAST
	pixel_x = 16
	pixel_y = 0

/obj/structure/lectern/west
	dir = WEST
	pixel_x = -16
	pixel_y = 0
