/atom
	var/obj/light/light_obj
	var/light_type = LIGHT_SOFT
	var/light_power = 1
	var/light_range = 1
	var/light_color = WHITE

/atom/destroy()
	if(light_obj)
		qdel(light_obj)
		light_obj = null
	return ..()

/atom/proc/kill_light()
	if(light_obj)
		qdel(light_obj)
		light_obj = null
	return

/atom/proc/set_light(var/l_range, var/l_power, var/l_color, var/fadeout)

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

	var/update_cast
	if(!light_obj)
		update_cast = 1
		light_obj = new(src)
	var/use_alpha = max(1,min(255,(l_power * 50)))
	if(light_obj.alpha != use_alpha)
		update_cast = 1
		light_obj.alpha = use_alpha
	if(light_obj.color != l_color)
		update_cast = 1
		light_obj.color = l_color
	if(light_obj.icon_state != light_type)
		update_cast = 1
		light_obj.icon_state = light_type
	if(light_obj.current_power != l_range)
		update_cast = 1
		light_obj.update_transform(l_range)

	if(update_cast)
		light_obj.follow_holder()

	if(fadeout)
		animate(light_obj, time=fadeout, alpha=0)

/mob
	var/image/master_plane/master_plane
	var/image/lighting_plane/lighting_plane

/mob/proc/update_env_light()
	return