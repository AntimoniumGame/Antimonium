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
	align_with_wall(src)

/obj/structure/sconce/update_icon()
	if(filled)
		if(filled.lit)
			icon_state = "sconce_lit"
			light_color = filled.light_color
			light_power = filled.light_power
			light_range = filled.light_range
			set_light()
		else
			icon_state = "sconce_filled"
			kill_light()
	else
		icon_state = "sconce"
		kill_light()

/obj/structure/sconce/attacked_by(var/mob/user, var/obj/item/thing)
	if(istype(thing, /obj/item/torch))
		if(filled)
			var/obj/item/torch/torch = thing
			if(filled)
				if(filled.lit && !torch.lit)
					user.notify_nearby("\The [user] lights \the [torch] from \the [src].")
					torch.lit = TRUE
					torch.update_light(user)
				else if(!filled.lit && torch.lit)
					user.notify_nearby("\The [user] lights \the [src] with \the [torch].")
					filled.lit = TRUE
					filled.update_light()
					update_icon()
				else
					user.notify("There is already \a [filled] in \the [src].")
				return

		user.drop_item(thing)
		user.notify_nearby("\The [user] places \the [thing] into \the [src].")
		thing.force_move(src)
		filled = thing
		update_icon()

/obj/structure/sconce/manipulated_by(var/mob/user, var/slot)
	if(filled)
		if(user.collect_item(filled, slot))
			user.notify_nearby("\The [user] removes \the [filled] from \the [src].")
			filled = null
			update_icon()
		else
			if(filled.loc != src)
				filled.force_move(src)
	else
		user.notify("There is no torch in \the [src].")
