/obj/structure/sconce
	name = "sconce"
	icon_state = "sconce"
	icon = 'icons/objects/structures/sconce.dmi'
	flags = FLAG_SIMULATED | FLAG_ANCHORED
	density = FALSE
	draw_shadow_underlay = null
	layer = MOB_LAYER + 0.2
	appearance_flags = TILE_BOUND

	var/obj/item/torch/filled

/obj/structure/sconce/GetFireIconState()
	return

/obj/structure/sconce/Ignite(var/mob/user)
	if(filled)
		. = filled.Ignite(user)
		UpdateIcon()

/obj/structure/sconce/IsOnFire()
	return filled && filled.IsOnFire()

/obj/structure/sconce/IsFlammable()
	return filled && filled.IsFlammable()

/obj/structure/sconce/New()
	if(prob(80))
		filled = new(src, _lit = TRUE)
	..()

/obj/structure/sconce/Initialize()
	..()
	AlignWithWall(src)

/obj/structure/sconce/SetDir()
	..()

	switch(dir)
		if(NORTH)
			pixel_x = 0
			pixel_y = -4
		if(SOUTH)
			pixel_x = 0
			pixel_y = 4
		if(EAST)
			pixel_x = -4
			pixel_y = 0
		if(WEST)
			pixel_x = 4
			pixel_y = 0

/obj/structure/sconce/UpdateFireOverlay()
	return

/obj/structure/sconce/UpdateIcon()
	if(filled)
		if(filled.IsOnFire())
			icon_state = "sconce_lit"
		else
			icon_state = "sconce_filled"
	else
		icon_state = "sconce"
	..()

/obj/structure/sconce/AttackedBy(var/mob/user, var/obj/item/prop)
	if(istype(prop, /obj/item/torch))
		if(filled)
			. = ..()
		if(!.)
			if(filled)
				user.Notify("<span class='warning'>There is already \a [filled] in \the [src].</span>")
			else
				user.DropItem(prop)
				user.NotifyNearby("<span class='notice'>\The [user] places \the [prop] into \the [src].</span>")
				prop.ForceMove(src)
				filled = prop
				UpdateIcon()
			return TRUE
	return ..()

/obj/structure/sconce/ManipulatedBy(var/mob/user, var/slot)
	if(filled)
		if(user.CollectItem(filled, slot))
			user.NotifyNearby("<span class='notice'>\The [user] removes \the [filled] from \the [src].</span>")
			filled = null
			UpdateIcon()
		else
			if(filled.loc != src)
				filled.ForceMove(src)
	else
		user.Notify("<span class='warning'>There is no torch in \the [src].</span>")
	return TRUE

/obj/structure/sconce/HandleFireDamage()
	return
