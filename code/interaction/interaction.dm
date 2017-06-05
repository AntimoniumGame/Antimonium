// Entry point for the click resolution chain.
/client/
	var/list/last_click = list()

/client/Click(object,location,control,params)
	last_click = params2list(params)
	if(world.time > next_click)
		next_click = world.time + 1
		interface.OnClick(object, location, control, params)

/atom/movable/proc/Burn(var/mob/user, var/slot)
	if(temperature >= user.burn_point && user.GetHeatInsulation(slot) < temperature)
		return TRUE
	return FALSE

/atom/proc/AttackedBy(var/mob/user, var/obj/item/prop)
	return
