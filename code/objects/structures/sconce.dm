/obj/structure/sconce
	name = "sconce"
	icon_state = "sconce"
	icon = 'icons/objects/structures/sconce.dmi'
	flags = FLAG_SIMULATED | FLAG_ANCHORED | FLAG_FLAMMABLE
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
		if(filled.on_fire)
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
	. = ..()
	if(!. && istype(thing, /obj/item/torch))
		if(filled)
			user.notify("There is already \a [filled] in \the [src].")
		else
			user.drop_item(thing)
			user.notify_nearby("\The [user] places \the [thing] into \the [src].")
			thing.force_move(src)
			filled = thing
			update_icon()
		return TRUE

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
