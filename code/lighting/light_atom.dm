/atom
	var/obj/light/light_obj
	var/light_type = LIGHT_SOFT
	var/light_power = 0
	var/light_range = 0
	var/light_color

/atom/Destroy()
	if(light_obj)
		QDel(light_obj)
		light_obj = null
	. = ..()

// Used to change hard BYOND opacity; this means a lot of updates are needed.
/atom/proc/SetOpacity(var/newopacity)
	opacity = newopacity ? 1 : 0
	var/turf/T = get_turf(src)
	if(istype(T))
		T.blocks_light = -1
		for(var/obj/light/L in range(get_turf(src), world.view)) //view(world.view, dview_mob))
			L.CastLight()

/atom/proc/CopyLight(var/atom/other)
	light_range = other.light_range
	light_power = other.light_power
	light_color = other.light_color
	SetLight()

/atom/proc/UpdateAllLights()
	spawn()
		if(light_obj && !Deleted(light_obj))
			light_obj.FollowHolder()

/atom/SetDir()
	. = ..()
	if(.)
		UpdateContainedLights()
		spawn()
			if(light_obj)
				light_obj.FollowHolderDir()

/atom/movable/Move()
	. = ..()
	if(.)
		UpdateContainedLights()
		spawn()
			if(light_obj)
				light_obj.FollowHolder()

/atom/movable/ForceMove()
	. = ..()
	if(.)
		UpdateContainedLights()
		spawn()
			if(light_obj)
				light_obj.FollowHolder()

/atom/proc/UpdateContainedLights(var/list/specific_contents)
	if(!specific_contents)
		specific_contents = contents
	for(var/thing in (specific_contents + src))
		var/atom/A = thing
		spawn()
			if(A && !Deleted(A))
				A.UpdateAllLights()
