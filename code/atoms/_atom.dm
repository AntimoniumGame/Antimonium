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

/atom/proc/UpdateIcon(var/list/supplied = list())
	overlays = supplied
	var/mob/holder = loc
	if(istype(holder))
		holder.UpdateInventory()
		holder.UpdateIcon()

/atom/proc/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	return

/atom/proc/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	return

/atom/proc/MiddleClickedOn(var/mob/clicker)
	ExaminedBy(clicker)

/atom/proc/ExaminedBy(var/mob/clicker)
	clicker.Notify("[(src != clicker) ? "That's" : "You're"] \a [name].")
	return IsAdjacentTo(src, clicker)

/atom/proc/PullCost()
	return 1

/atom/New()
	..()
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

/atom/proc/get_amount()
	return 1

/atom/proc/set_fire_light()
	if(light_obj)
		kill_light()
	light_color = BRIGHT_ORANGE
	light_power = 10
	light_range = 5
	set_light()

/atom/proc/reset_lights()
	var/lit
	if(light_obj)
		lit = TRUE
		kill_light()
	light_color = initial(light_color)
	light_power = initial(light_power)
	light_range = initial(light_range)
	if(lit && (light_power || light_color || light_range))
		set_light()
