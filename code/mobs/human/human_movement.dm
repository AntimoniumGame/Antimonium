/mob/human/get_move_delay()
	. = ..()
	if(prone)
		. += 10


/mob/human/Move()

	// Make sure we still have active grabs before moving the grabbed.
	for(var/thing in active_grabs)
		var/obj/item/grab/grab = thing
		// If the grab persists, move whatever they're dragging.
		if(istype(grab))
			grab.check_state()

	var/last_loc = loc
	. = ..()

	// Update again if we moved.
	if(.) // Also move anything we're dragging a step towards us.
		for(var/thing in active_grabs)
			var/obj/item/grab/grab = thing
			if(istype(grab))
				var/turf/last_grabbed_loc = get_turf(grab.grabbed)
				grab.grabbed.dragged = TRUE
				grab.grabbed.face_atom(last_loc)
				grab.grabbed.glide_size = glide_size
				step_towards(grab.grabbed, last_loc)
				grab.grabbed.handle_dragged(last_grabbed_loc, grab.grabbed.loc)
				grab.grabbed.dragged = FALSE

				grab.check_state()

/mob/human/handle_dragged(var/turf/from_turf, var/turf/to_turf)
	if(prone)
		for(var/thing in injured_limbs)
			var/obj/item/limb/limb = thing
			if(limb.is_bleeding())
				blood_smear(src, from_turf, to_turf)
