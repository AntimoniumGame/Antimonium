/obj/light
	mouse_opacity = 0
	plane = LIGHTING_PLANE
	layer = EFFECTS_LAYER
	icon = 'icons/lighting/overlays.dmi'
	appearance_flags = KEEP_TOGETHER
	pixel_x = -48
	pixel_y = -48
	blend_mode = BLEND_ADD

	var/current_power = 1
	var/atom/movable/holder
	var/point_angle

/obj/light/New(var/newholder)
	holder = newholder
	icon_state = holder.light_type
	blend_mode = BLEND_ADD
	mouse_opacity = 0
	..(get_turf(holder))

/obj/light/destroy()
	if(holder)
		if(holder.light_obj == src)
			holder.light_obj = null
		holder = null
	return .. ()

/obj/light/New()
	..()
	follow_holder_dir()
	follow_holder()

/obj/light/proc/update_transform(var/newrange)
	if(!isnull(newrange) && current_power != newrange)
		current_power = newrange
	var/matrix/M = matrix()
	if(!isnull(point_angle))
		M.Turn(point_angle)
	M.Scale(current_power)
	animate(src, transform = M, time = 10)

/obj/light/proc/follow_holder_dir()
	if(istype(holder.loc, /mob) && holder.dir != holder.loc.dir)
		holder.set_dir(holder.loc.dir)
	if(dir != holder.dir)
		set_dir(holder.dir)

	if(icon_state == LIGHT_DIRECTIONAL)
		var/last_angle = point_angle
		switch(dir)
			if(NORTH)     point_angle = 90
			if(SOUTH)     point_angle = -90
			if(EAST)      point_angle = -180
			if(WEST)      point_angle = 0
			if(NORTHEAST) point_angle = 135
			if(NORTHWEST) point_angle = 45
			if(SOUTHEAST) point_angle = -135
			if(SOUTHWEST) point_angle = -45
			else          point_angle = null
		if(last_angle != point_angle)
			update_transform()

/obj/light/proc/follow_holder()
	glide_size = holder.glide_size
	move_to(get_turf(holder))