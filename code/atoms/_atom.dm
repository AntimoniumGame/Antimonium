/atom
	name = ""
	plane = MASTER_PLANE
	layer = UNDERLAY_LAYER
	var/simulated = TRUE
	var/ethereal = FALSE

/atom/movable
	animate_movement = SLIDE_STEPS
	var/anchored = FALSE
	var/dragged = FALSE
	var/self_move = FALSE
	var/move_sound

/atom/proc/update_icon()
	return

/atom/proc/left_clicked_on(var/mob/clicker)
	return

/atom/proc/right_clicked_on(var/mob/clicker)
	return

/atom/proc/middle_clicked_on(var/mob/clicker)
	return

/atom/movable/proc/pull_cost()
	return 1

/atom/movable/proc/handle_dragged(var/turf/from_turf, var/turf/to_turf)
	if(move_sound)
		play_local_sound(src, move_sound, 20, frequency = -1)

/atom/proc/thrown_hit_by(var/atom/movable/projectile)
	return FALSE

/atom/proc/update_strings()
	name = initial(name)
