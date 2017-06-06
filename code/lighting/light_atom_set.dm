// Destroys and removes a light; replaces previous system's SetLight(0).
/atom/proc/KillLight()
	if(light_obj)
		QDel(light_obj)
		light_obj = null
	return

// Updates all appropriate lighting values and then applies all changed values
// to the objects light_obj overlay atom.
/atom/proc/SetLight(var/l_range, var/l_power, var/l_color, var/fadeout)

	if(!istype(src, /turf) && !loc)
		if(light_obj)
			QDel(light_obj)
			light_obj = null
		return

	// Update or retrieve our variable data.
	if(isnull(l_range))
		l_range = light_range
	else
		light_range = l_range
	if(isnull(l_power))
		l_power = light_power
	else
		light_power = l_power
	if(isnull(l_color))
		l_color = light_color
	else
		light_color = l_color

	// Apply data and update light casting/bleed masking.
	var/update_cast
	if(!light_obj)
		update_cast = 1
		light_obj = new(src)

	if(light_obj.light_power != l_power)
		update_cast = 1
		light_obj.light_power = l_power

	if(light_obj.current_power != l_range)
		update_cast = 1
		light_obj.UpdateTransform(l_range)

	if(!light_obj.alpha)
		update_cast = 1

	// Makes sure the obj isn't somewhere weird (like inside the holder). Also calls bleed masking.
	if(update_cast)
		light_obj.FollowHolder()

	// Rare enough that we can probably get away with calling animate(). Currently used by muzzle flashes and sparks.
//	if(fadeout) animate(light_obj.light_overlay, time=fadeout, alpha=0)

/obj/light/SetLight()
	return
