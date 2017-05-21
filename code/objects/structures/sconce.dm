/obj/structure/sconce
	name = "sconce"
	icon_state = "sconce"
	icon = 'icons/objects/structures/sconce.dmi'
	flags = FLAG_SIMULATED | FLAG_ANCHORED
	density = FALSE
	shadow_size = null

	var/obj/item/torch/filled

/obj/structure/sconce/GetFireIcon()
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

/obj/structure/sconce/UpdateIcon(var/list/supplied)
	..(supplied)
	if(filled)
		if(filled.IsOnFire())
			icon_state = "sconce_lit"
			light_color = filled.light_color
			light_power = filled.light_power
			light_range = filled.light_range
			SetLight()
		else
			icon_state = "sconce_filled"
			KillLight()
	else
		icon_state = "sconce"
		KillLight()

/obj/structure/sconce/AttackedBy(var/mob/user, var/obj/item/thing)
	if(istype(thing, /obj/item/torch))
		if(filled)
			. = ..()
		if(!.)
			if(filled)
				user.Notify("There is already \a [filled] in \the [src].")
			else
				user.DropItem(thing)
				user.NotifyNearby("\The [user] places \the [thing] into \the [src].")
				thing.ForceMove(src)
				filled = thing
				UpdateIcon()
			return TRUE
	return ..()

/obj/structure/sconce/ManipulatedBy(var/mob/user, var/slot)
	if(filled)
		if(user.CollectItem(filled, slot))
			user.NotifyNearby("\The [user] removes \the [filled] from \the [src].")
			filled = null
			UpdateIcon()
		else
			if(filled.loc != src)
				filled.ForceMove(src)
	else
		user.Notify("There is no torch in \the [src].")
