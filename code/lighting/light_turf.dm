/turf
	var/list/light_ao_overlays = list()
	var/list/light_area_overlays = list()
	var/list/light_spill_overlays = list()
	var/area/blend_area

/turf/proc/RefreshLighting()

/turf/floor/UpdateIcon()
	..()
	UpdateLight()

/turf/floor/UpdateLight()
	var/list/overlay_list = overlays
	overlay_list -= light_ao_overlays
	light_ao_overlays.Cut()

	var/list/connected_neighbors = list()
	for(var/thing in Trange(1,src))
		if(thing == src)
			continue
		var/turf/neighbor = thing
		if(neighbor.opacity)
			continue
		connected_neighbors += get_dir(src, neighbor)

	for(var/i = 1 to 4)
		var/cdir = corner_dirs[i]
		var/corner = 0
		if(cdir in connected_neighbors)
			corner |= 2
		if(turn(cdir,45) in connected_neighbors)
			corner |= 1
		if(turn(cdir,-45) in connected_neighbors)
			corner |= 4
		var/image/I = image('icons/images/turf_shadows.dmi', "[corner]", dir = 1<<(i-1))
		I.plane = LIGHTING_PLANE
		I.layer = LIGHT_LAYER_AO
		I.blend_mode = BLEND_OVERLAY
		I.alpha = 128
		light_ao_overlays += I

	overlay_list += light_ao_overlays

	if(loc && loc.type != MASTER_LIGHT_AREA)
		overlay_list -= light_spill_overlays
		light_spill_overlays.Cut()

		for(var/d in cardinal_dirs)
			var/turf/T = get_step(src, d)
			if(T && T.loc != loc)
				if(isarea(T.loc))
					blend_area = T.loc

				var/light_data/L = blend_area.GetLight()
				if(!L) continue

				var/turf/C = get_step(src, turn(d, 90)) // turf to left of the direction the light is going
				var/image/IL = image('icons/images/door_spill.dmi', dir = d)
				IL.plane = LIGHTING_PLANE
				IL.layer = LIGHT_LAYER_TURF
				IL.blend_mode = BLEND_OVERLAY
				IL.pixel_x = IL.pixel_y = -32
				if(C && C.opacity)
					IL.icon_state = "left_spill"
				else
					IL.icon_state = "left_blocked"
				light_spill_overlays += IL

				C = get_step(src, turn(d, -90)) // turf to right of the direction the light is going
				var/image/IR = image('icons/images/door_spill.dmi', dir = d)
				IR.plane = LIGHTING_PLANE
				IR.layer = LIGHT_LAYER_TURF
				IR.blend_mode = BLEND_OVERLAY
				IR.pixel_x = IR.pixel_y = -32
				if(C && C.opacity)
					IR.icon_state = "right_spill"
				else
					IR.icon_state = "right_blocked"
				light_spill_overlays += IR
				break

		if(istype(blend_area))
			blend_area.lighting_blend_turfs -= src
			if(light_spill_overlays.len)
				blend_area.lighting_blend_turfs += src

		RefreshLighting()

	overlays = overlay_list

/turf/floor/RefreshLighting()
	var/list/overlay_list = overlays
	overlay_list -= light_spill_overlays

	for(var/image/I in light_spill_overlays)
		if(blend_area && blend_area.light)
			I.color = blend_area.light.color
		else
			I.color = null

	overlay_list += light_spill_overlays
	overlays = overlay_list

/turf/wall/UpdateIcon()
	..()
	UpdateLight()

/turf/wall/UpdateLight()
	if(loc && loc.type == MASTER_LIGHT_AREA)
		return

	var/list/overlay_list = overlays
	overlay_list -= light_area_overlays
	overlays = overlay_list

	light_area_overlays.len = 0

	var/list/check_corner_dirs = list()
	check_corner_dirs += corner_dirs
	var/list/check_dirs = list()
	check_dirs += cardinal_dirs

	var/d = check_dirs[1]
	while(d)
		check_dirs -= d
		var/turf/T = get_step(src, d)
		if(T && T.loc != loc)
			blend_area = T.loc
			var/overlay_state = d
			for(var/c in check_corner_dirs)
				if(c & d)
					check_corner_dirs -= c
			for(var/c in check_dirs)
				check_dirs -= c
				var/turf/C = get_step(src, c)
				if(C && C.loc != loc)
					overlay_state |= c
					for(var/cd in check_corner_dirs)
						if(cd & c)
							check_corner_dirs -= cd
			var/image/I = image('icons/images/turf_blending.dmi', "[overlay_state]")
			I.plane = LIGHTING_PLANE
			I.layer = LIGHT_LAYER_TURF
			I.blend_mode = BLEND_OVERLAY
			light_area_overlays += I
		if(check_dirs.len)
			d = check_dirs[1]
		else
			d = null

	for(var/c in check_corner_dirs)
		check_corner_dirs -= c
		var/turf/T = get_step(src, c)
		if(T && T.loc != loc)
			blend_area = T.loc
			var/image/I = image('icons/images/turf_blending.dmi', "c_[c]")
			I.plane = LIGHTING_PLANE
			I.layer = LIGHT_LAYER_TURF
			I.blend_mode = BLEND_OVERLAY
			light_area_overlays += I

	if(istype(blend_area))
		blend_area.lighting_blend_turfs -= src
		if(light_area_overlays.len)
			blend_area.lighting_blend_turfs += src

	RefreshLighting()

/turf/wall/RefreshLighting()
	var/list/overlay_list = overlays
	overlay_list -= light_area_overlays

	for(var/image/I in light_area_overlays)
		if(blend_area && blend_area.light)
			I.color = blend_area.light.color
		else
			I.color = null

	overlay_list += light_area_overlays
	overlays = overlay_list

/client/verb/updateturflight()
	set name = "Update turf lighting"
	set category = "Debug"
	var/turf/T = get_step(mob, mob.dir)
	T.UpdateLight()
