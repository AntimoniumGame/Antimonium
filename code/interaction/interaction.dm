// Entry point for the click resolution chain.
/client/Click(object,location,control,params)
	if(world.time > next_click)
		next_click = world.time + 1
		interface.on_click(object, location, control, params)

/atom/movable/proc/burn(var/mob/user, var/slot)
	if(temperature >= TEMPERATURE_BURNING && user.get_heat_insulation(slot) < TEMPERATURE_BURNING)
		user.notify("\The [src] is far too hot to handle!")
		return TRUE
	return FALSE
