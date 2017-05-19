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

/atom/proc/update_icon()
	return

/atom/proc/left_clicked_on(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	return

/atom/proc/right_clicked_on(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	return

/atom/proc/middle_clicked_on(var/mob/clicker)
	examined_by(clicker)

/atom/proc/examined_by(var/mob/clicker)
	clicker.notify("[(src != clicker) ? "That's" : "You're"] \a [name].")
	return is_adjacent_to(src, clicker)

/atom/proc/pull_cost()
	return 1

/atom/New()
	..()
	update_strings()
	update_icon()

/atom/movable/proc/handle_dragged(var/turf/from_turf, var/turf/to_turf)
	if(move_sound)
		play_local_sound(src, move_sound, 35, frequency = -1)

/atom/proc/update_strings()
	name = initial(name)

/atom/proc/airtight()
	return FALSE

/atom/proc/is_solid()
	return TRUE

/atom/proc/get_weight()
	return 1

/atom/proc/get_amount()
	return 1