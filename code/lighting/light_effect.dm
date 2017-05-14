/obj/light
	simulated = 0
	mouse_opacity = 0
	plane = DARK_PLANE

	layer = 1
	//layer 1 = base plane layer
	//layer 2 = base shadow templates
	//layer 3 = wall lighting overlays
	//layer 4 = light falloff overlay

	appearance_flags = KEEP_TOGETHER
	icon = null
	invisibility = INVISIBILITY_LIGHTING
	pixel_x = -64
	pixel_y = -64
	glide_size = 32
	blend_mode = BLEND_ADD

	alpha = 180

	var/current_power = 1
	var/atom/movable/holder
	var/point_angle
	var/list/affecting_turfs = list()
	var/list/temp_appearance

/obj/light/New(var/newholder)
	holder = newholder
	if(istype(holder, /atom))
		var/atom/A = holder
		light_range = A.light_range
		light_color = A.light_color
		light_power = A.light_power
		color = light_color
	..(get_turf(holder))

/obj/light/destroy()

	transform = null
	appearance = null
	overlays = null
	temp_appearance = null

	if(holder)
		if(holder.light_obj == src)
			holder.light_obj = null
		holder = null
	for(var/thing in affecting_turfs)
		var/turf/T = thing
		T.lumcount = -1
		T.affecting_lights -= src
	affecting_turfs.Cut()
	. = ..()

// Applies power value to size (via Scale()) and updates the current rotation (via Turn())
// angle for directional lights. This is only ever called before cast_light() so affected turfs
// are updated elsewhere.
/obj/light/proc/update_transform(var/newrange)
	if(!isnull(newrange) && current_power != newrange)
		current_power = newrange

// Orients the light to the holder's (or the holder's holder) current dir.
// Also updates rotation for directional lights when appropriate.
/obj/light/proc/follow_holder_dir()
	if(holder.loc.loc && ismob(holder.loc))
		set_dir(holder.loc.dir)
	else
		set_dir(holder.dir)

// Moves the light overlay to the holder's turf and updates bleeding values accordingly.
/obj/light/proc/follow_holder()

	if(!holder || deleted(src))
		null_loc()
		destroy(src)
		return

	if(holder && holder.loc)
		if(holder.loc.loc && ismob(holder.loc))
			force_move(holder.loc.loc)
		else
			force_move(holder.loc)
		follow_holder_dir()
		cast_light() //lights_master.queue_light(src)

/obj/light/proc/is_directional_light()
	return (holder.light_type == LIGHT_DIRECTIONAL)

/obj/light/set_dir()
	. = ..()
	switch(dir)
		if(NORTH)
			pixel_x = -(world.icon_size * light_range) + world.icon_size / 2
			pixel_y = 0
		if(SOUTH)
			pixel_x = -(world.icon_size * light_range) + world.icon_size / 2
			pixel_y = -(world.icon_size * light_range) - world.icon_size * light_range + world.icon_size
		if(EAST)
			pixel_x = 0
			pixel_y = -(world.icon_size * light_range) + world.icon_size / 2
		if(WEST)
			pixel_x = -(world.icon_size * light_range) - (world.icon_size * light_range) + world.icon_size
			pixel_y = -(world.icon_size * light_range) + (world.icon_size / 2)

/obj/light/proc/light_off()
	alpha = 0
