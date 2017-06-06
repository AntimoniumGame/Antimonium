/atom
	name = ""
	plane = MASTER_PLANE
	layer = UNDERLAY_LAYER
	var/flags = FLAG_SIMULATED | FLAG_THROWN_SPIN

/atom/movable
	animate_movement = SLIDE_STEPS
	var/dragged = FALSE
	var/self_move = FALSE
	var/move_sound

	var/draw_shadow_underlay = null
	var/shadow_pixel_x = 0
	var/shadow_pixel_y = 0

/atom/proc/UpdateIcon(var/list/supplied = list(), var/ignore_neighbors = FALSE)
	overlays = supplied
	var/mob/holder = loc
	if(istype(holder))
		holder.UpdateInventory()
		holder.UpdateIcon()

/atom/movable/UpdateIcon(var/list/supplied = list())
	..(supplied)
	if((flags & FLAG_SIMULATED) && draw_shadow_underlay)
		underlays.Cut()
		var/image/I = image(null)
		I.appearance = src
		I.color = "#000000"
		I.alpha = 60
		I.plane = plane
		I.layer = layer
		I.pixel_x = shadow_pixel_x
		I.pixel_y = shadow_pixel_y
		var/matrix/M = matrix()
		M.Scale(1.1)
		I.transform = M
		underlays += I

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
	if(!game_state || game_state.ident == GAME_SETTING_UP)
		atoms_to_initialize += src
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
	if(light_obj)
		KillLight()
	light_color = BRIGHT_ORANGE
	light_power = 10
	light_range = 5
	SetLight()

/atom/proc/ResetLights()
	var/lit
	if(light_obj)
		lit = TRUE
		KillLight()
	light_color = initial(light_color)
	light_power = initial(light_power)
	light_range = initial(light_range)
	if(lit && (light_power || light_color || light_range))
		SetLight()

/atom/proc/SmearWith(var/datum/material/smearing, var/amount)
	return

/atom/proc/Grind(var/mob/user)
	return FALSE

/atom/MouseDrop(var/atom/over_object,src_location,over_location,src_control,over_control,params)
	. = ..()
	if(!isnull(over_object) && IsAdjacentTo(src, over_object) && IsAdjacentTo(usr, over_object) && IsAdjacentTo(usr, src))
		var/list/arguments = params2list(params)
		DraggedOntoThing(usr, over_object, arguments["left"], arguments["right"], arguments["middle"])
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

/atom/movable/proc/EndThrow()
	return
