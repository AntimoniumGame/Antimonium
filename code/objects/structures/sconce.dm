/obj/structure/sconce
	name = "sconce"
	icon_state = "sconce"
	icon = 'icons/objects/structures/sconce.dmi'
	flags = FLAG_SIMULATED | FLAG_ANCHORED
	light_color = BRIGHT_ORANGE
	light_power = 8
	light_range = 4
	density = FALSE

	var/obj/item/torch/filled

/obj/structure/sconce/New()
	if(prob(80))
		filled = new(src, _lit = TRUE)
	..()
	AlignWithWall(src)

/obj/structure/sconce/UpdateIcon()
	if(filled)
		if(filled.lit)
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
			var/obj/item/torch/torch = thing
			if(filled)
				if(filled.lit && !torch.lit)
					user.NotifyNearby("\The [user] lights \the [torch] from \the [src].")
					torch.lit = TRUE
					torch.UpdateLight(user)
				else if(!filled.lit && torch.lit)
					user.NotifyNearby("\The [user] lights \the [src] with \the [torch].")
					filled.lit = TRUE
					filled.UpdateLight()
					UpdateIcon()
				else
					user.Notify("There is already \a [filled] in \the [src].")
				return

		user.DropItem(thing)
		user.NotifyNearby("\The [user] places \the [thing] into \the [src].")
		thing.ForceMove(src)
		filled = thing
		UpdateIcon()

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
