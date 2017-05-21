// Entry point for the click resolution chain.
/client/Click(object,location,control,params)
	if(world.time > next_click)
		next_click = world.time + 1
		interface.OnClick(object, location, control, params)

/atom/movable/proc/Burn(var/mob/user, var/slot)
	if(temperature >= TEMPERATURE_BURNING && user.GetHeatInsulation(slot) < TEMPERATURE_BURNING)
		user.Notify("\The [src] is far too hot to handle!")
		return TRUE
	return FALSE

/atom/proc/AttackedBy(var/mob/user, var/obj/item/prop)
	return
