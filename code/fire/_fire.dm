/atom
	var/on_fire = FALSE

/atom/proc/get_fire_icon()
	return image('icons/images/fire.dmi', "mid")

/atom/update_icon(var/list/supplied = list())
	if(is_on_fire())
		var/image/I = get_fire_icon()
		if(I)
			supplied += I
	..(supplied)

/atom/proc/can_ignite()
	return is_flammable()

/atom/proc/ignite(var/mob/user)
	if(can_ignite() && !is_on_fire())
		burning_atoms |= src
		on_fire = TRUE
		set_fire_light()
		update_icon()
		return TRUE
	return FALSE

/atom/proc/extinguish(var/mob/user)
	if(is_on_fire())
		burning_atoms -= src
		on_fire = FALSE
		reset_lights()
		update_icon()
		return TRUE
	return FALSE

/atom/proc/is_flammable()
	return ((flags & FLAG_FLAMMABLE) && (flags & FLAG_SIMULATED))

/atom/proc/is_on_fire()
	return on_fire
