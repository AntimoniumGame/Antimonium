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
	max_contains_count =       1
	max_contains_size_single = 30
	max_contains_size_total =  30

	var/obj/item/written/holding
	var/image/book_overlay

/obj/structure/lectern/CanAcceptItem(var/obj/item/prop)
	return ..() && istype(prop, /obj/item/written)

/obj/structure/lectern/ThingPutInside(var/obj/item/prop)
	..()
	if(!holding)
		holding = prop
		UpdateBookOverlay()

/obj/structure/lectern/ThingTakenOut(var/obj/item/prop)
	..()
	if(holding == prop)
		holding = null
		UpdateBookOverlay()

/obj/structure/lectern/proc/UpdateBookOverlay()
	if(book_overlay)
		overlays -= book_overlay
	if(holding)
		book_overlay = holding.GetWornIcon("lectern")
		overlays += book_overlay

/obj/structure/lectern/ManipulatedBy(var/mob/user, var/slot)
	. = ..()
	if(!. && holding)
		contains -= holding
		holding.ForceMove(get_turf(src))
		if(user.CollectItem(holding, slot))
			user.NotifyNearby("\The [user] removes \the [holding] from \the [src].", MESSAGE_VISIBLE)
			ThingTakenOut(holding)
			holding = null
			UpdateBookOverlay()
			return TRUE
		else
			contains += holding
			holding.ForceMove(src)

/obj/structure/lectern/UpdateIcon()
	..()
	UpdateBookOverlay()

/obj/structure/lectern/New()
	..()
	if(prob(60))
		var/filled = pick(typesof(/obj/item/written))
		holding = new filled(src)
		contains += holding
		UpdateBookOverlay()

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
