/mob/human/Move()
	if(prone && !dragged)
		return FALSE

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
				grab.grabbed.handle_dragged()
				grab.grabbed.dragged = TRUE
				grab.grabbed.face_atom(last_loc)
				grab.grabbed.move_to(get_step_towards(grab.grabbed, last_loc))

				//step(grab.grabbed, grab.grabbed.dir)
				grab.grabbed.dragged = FALSE
				grab.check_state()

/mob/human/handle_dragged()
	for(var/thing in injured_limbs)
		var/obj/item/limb/limb = thing
		if(limb.is_bleeding())
			blood_splatter(src, loc)
