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

/atom/proc/UpdateIcon()
	return

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
