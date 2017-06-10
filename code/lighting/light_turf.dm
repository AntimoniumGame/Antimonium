/turf
	var/area/blend_area

/turf/proc/RefreshLighting()
	return

/turf/floor/
	var/list/light_ao_overlays = list()
	var/list/light_spill_overlays = list()

/turf/floor/UpdateIcon()
	..()
	UpdateAO()
	UpdateSpillLight()

/turf/floor/proc/UpdateAO()
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
		var/image/I = CreateLightOverlay('icons/images/turf_shadows.dmi', "[corner]", 1<<(i-1), LIGHTING_PLANE, LIGHT_LAYER_AO, BLEND_OVERLAY, 0)
		I.alpha = 128
		light_ao_overlays += I

	overlay_list += light_ao_overlays
	overlays = overlay_list

/turf/floor/proc/UpdateSpillLight()
	if(!loc || loc.type == MASTER_LIGHT_AREA)
		return

	var/list/overlay_list = overlays
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

			var/overlay_state
			if(C && C.opacity)
				overlay_state = "left_spill"
			else
				overlay_state = "left_blocked"

			var/image/left_overlay = CreateLightOverlay('icons/images/door_spill.dmi', overlay_state, d, LIGHTING_PLANE, LIGHT_LAYER_TURF, BLEND_OVERLAY, -32)
			light_spill_overlays += left_overlay

			C = get_step(src, turn(d, -90)) // turf to right of the direction the light is going

			if(C && C.opacity)
				overlay_state = "right_spill"
			else
				overlay_state = "right_blocked"

			var/image/right_overlay = CreateLightOverlay('icons/images/door_spill.dmi', overlay_state, d, LIGHTING_PLANE, LIGHT_LAYER_TURF, BLEND_OVERLAY, -32)
			light_spill_overlays += right_overlay

			break

	if(istype(blend_area))
		blend_area.lighting_blend_turfs -= src
		if(light_spill_overlays.len)
			blend_area.lighting_blend_turfs += src

	RefreshLighting()

/turf/floor/RefreshLighting()
	var/list/overlay_list = overlays
	overlay_list -= light_spill_overlays

	for(var/image/I in light_spill_overlays)
		if(blend_area)
			I.color = blend_area.GetLightColor()
		else
			I.color = null

	overlay_list += light_spill_overlays
	overlays = overlay_list

/turf/wall
	var/list/light_area_overlays = list()
	var/list/map_edge_overlays = list()

/turf/wall/UpdateIcon()
	..()
	UpdateAreaBlending()
	UpdateMapEdgeBlending()

/turf/wall/proc/UpdateAreaBlending()
	if(!loc || loc.type == MASTER_LIGHT_AREA)
		return

	var/list/overlay_list = overlays
	overlay_list -= light_area_overlays
	light_area_overlays.Cut()

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

			var/image/I = CreateLightOverlay('icons/images/turf_blending.dmi', "[overlay_state]", 0, LIGHTING_PLANE, LIGHT_LAYER_TURF, BLEND_OVERLAY, 0)
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
			var/image/I = CreateLightOverlay('icons/images/turf_blending.dmi', "c_[c]", 0, LIGHTING_PLANE, LIGHT_LAYER_TURF, BLEND_OVERLAY, 0)
			light_area_overlays += I

	if(istype(blend_area))
		blend_area.lighting_blend_turfs -= src
		if(light_area_overlays.len)
			blend_area.lighting_blend_turfs += src

	//we add light_area_overlays to overlays in the next proc
	RefreshLighting()

/turf/wall/proc/UpdateMapEdgeBlending()
	if(!loc)
		return

	var/list/overlay_list = overlays
	overlay_list -= map_edge_overlays
	map_edge_overlays.Cut()

	var/d = 0
	if(x == 1)
		d |= WEST
	else if(x == world.maxx)
		d |= EAST

	if(y == 1)
		d |= SOUTH
	else if(y == world.maxy)
		d |= NORTH

	if(d > 0)
		var/image/I = CreateLightOverlay('icons/images/turf_blending.dmi', "[d]", 0, LIGHTING_PLANE, LIGHT_LAYER_OVERRIDE, BLEND_OVERLAY, 0)
		I.color = "#000"
		map_edge_overlays += I

	overlay_list += map_edge_overlays
	overlays = overlay_list

/turf/wall/RefreshLighting()
	var/list/overlay_list = overlays
	overlay_list -= light_area_overlays

	for(var/image/I in light_area_overlays)
		if(blend_area)
			I.color = blend_area.GetLightColor()
		else
			I.color = null

	overlay_list += light_area_overlays
	overlays = overlay_list

/client/verb/updateturflight()
	set name = "Update turf lighting"
	set category = "Debug"
	var/turf/T = get_step(mob, mob.dir)
	T.UpdateLight()
