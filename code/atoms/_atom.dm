/atom
	name = ""
	plane = MASTER_PLANE
	layer = UNDERLAY_LAYER
	var/flags = FLAG_SIMULATED | FLAG_THROWN_SPIN

	var/damage = 0
	var/max_damage = 10

/atom/movable
	animate_movement = SLIDE_STEPS
	var/dragged = FALSE
	var/self_move = FALSE
	var/move_sound

	var/draw_shadow_underlay = null
	var/shadow_pixel_x = 0
	var/shadow_pixel_y = 0

	var/image/shadow_underlay	// the shadow underlay for this object

/atom/proc/TakeDamage(var/dam, var/source, var/dtype = WOUND_BRUISE)
	UpdateDamageOverlay()

/atom/proc/UpdateIcon()
	UpdateDamageOverlay()

/atom/proc/UpdateDamageOverlay()
	//TODO proper indicator of object damage.
	var/dam_per = 255-round((damage/max_damage)*80)
	color = rgb(dam_per,dam_per,dam_per)

/atom/proc/GetRadialMenuContents(var/mob/user, var/menu_type, var/args)
	return list()

/atom/movable/proc/UpdateShadowUnderlay()
	underlays -= shadow_underlay
	if(draw_shadow_underlay)
		shadow_underlay = image(null)
		shadow_underlay.appearance = src
		shadow_underlay.color = "#000000"
		shadow_underlay.alpha = 60
		shadow_underlay.plane = FLOAT_PLANE
		shadow_underlay.layer = FLOAT_LAYER
		shadow_underlay.pixel_x = shadow_pixel_x
		shadow_underlay.pixel_y = shadow_pixel_y
		var/matrix/M = matrix()
		M.Scale(1.1)
		shadow_underlay.transform = M

		underlays += shadow_underlay

/atom/movable/proc/CanPassProne()
	return TRUE

/atom/proc/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	return

/atom/proc/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	return

/atom/proc/MiddleClickedOn(var/mob/clicker)
	ExaminedBy(clicker)

/atom/proc/ExaminedBy(var/mob/clicker)
	clicker.Notify("<span class='notice'>[(src != clicker) ? "That's" : "You're"] <span class='alert'>\a [name]</span>.</span>")
	return IsAdjacentTo(src, clicker)

/atom/proc/PullCost()
	return 1

/atom/New()
	..()
	if(!glob.game_state || glob.game_state.ident == GAME_SETTING_UP)
		glob.atoms_to_initialize += src
	else
		Initialize()

/atom/proc/Initialize()
	SetDir(dir)
	UpdateStrings()
	UpdateIcon()

/atom/movable/proc/HandleDragged(var/turf/from_turf, var/turf/to_turf)
	if(move_sound)
		PlayLocalSound(src, move_sound, 35, frequency = -1)

/atom/proc/UpdateStrings()
	name = initial(name)

/atom/proc/Airtight()
	return FALSE

/atom/proc/IsSolid()
	return TRUE

/atom/proc/GetWeight()
	return 1

/atom/proc/GetAmount()
	return 1

/atom/proc/SetFireLight()
	// stubbed off for now
	return

/atom/proc/ResetLights()
	// and here
	return

/atom/proc/SmearWith(var/datum/material/smearing, var/amount)
	return

/atom/proc/Grind(var/mob/user)
	return FALSE

/atom/MouseDrop(var/atom/over_object,src_location,over_location,src_control,over_control,params)
	. = ..()
	if(!isnull(over_object) && IsAdjacentTo(src, over_object) && IsAdjacentTo(usr, over_object) && IsAdjacentTo(usr, src))
		var/list/arguments = params2list(params)
		DraggedOntoThing(usr, over_object, arguments["left"], arguments["right"], arguments["middle"])
		if(src && over_object && usr)
			over_object.ThingDraggedOnto(usr, src, arguments["left"], arguments["right"], arguments["middle"])

/atom/proc/ThingDraggedOnto(var/mob/user, var/atom/thing, var/left_drag, var/right_drag, var/middle_drag)
	return

/atom/proc/DraggedOntoThing(var/mob/user, var/atom/thing, var/left_drag, var/right_drag, var/middle_drag)
	return

/atom/proc/ResetPosition()
	pixel_x = initial(pixel_x)
	pixel_y = initial(pixel_y)
	transform = null

/atom/proc/RandomizePixelOffset()
	return

/atom/movable/RandomizePixelOffset()
	pixel_x = rand(8,24)-16
	pixel_y = rand(8,24)-16

/atom/movable/proc/EndThrow(var/throw_force)
	return
