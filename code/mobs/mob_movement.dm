/mob
	var/next_move = 0
	var/walking = TRUE
	var/walk_delay = 2
	var/run_delay = 1

/mob/CanMove()
	return (dragged || (world.time >= next_move))

/mob/Move()

	if(NoDeadMove() && dead && !dragged)
		return FALSE

	if(loc && !istype(loc, /turf))
		var/atom/atom = loc
		next_move = world.time + atom.MovementInContents(src)
		return FALSE

	// Make sure we still have active grabs before moving the grabbed.
	if(flags & FLAG_SIMULATED)
		for(var/thing in active_grabs)
			var/obj/item/grab/grab = thing
			// If the grab persists, move whatever they're dragging.
			if(istype(grab))
				grab.CheckState()

	if(sitting)
		ToggleSitting()

	var/last_loc = loc

	. = ..()

	if(.)

		if(flags & FLAG_SIMULATED)
			for(var/thing in smeared_with)
				var/datum/material/mat = thing
				smeared_with[mat]--
				if(smeared_with[mat] <= 0)
					smeared_with[mat] = null
					smeared_with -= mat
				Smear(last_loc, loc, mat.type, !prone)

			// Move anything we're dragging a step towards us.
			for(var/thing in active_grabs)
				var/obj/item/grab/grab = thing
				if(istype(grab))
					if(!(grab.grabbed.flags & FLAG_ANCHORED))
						var/turf/last_grabbed_loc = get_turf(grab.grabbed)
						grab.grabbed.dragged = TRUE
						grab.grabbed.FaceAtom(last_loc)
						grab.grabbed.glide_size = glide_size
						step_towards(grab.grabbed, last_loc)
						grab.grabbed.HandleDragged(last_grabbed_loc, grab.grabbed.loc)
						grab.grabbed.dragged = FALSE
					grab.CheckState()

		next_move = world.time + GetMoveDelay()
		UpdateVisionCone()
		for(var/mob/M in viewers(world.view, get_turf(src)))
			if(M.client)
				M.UpdateVisionCone()

/mob/Bump(var/atom/movable/obstacle)
	if(obstacle.PushedBy(src, dir))
		next_move = world.time + max(1, GetMoveDelay() + round(obstacle.PullCost()/2))

/atom/proc/PushedBy(var/mob/pusher, var/mob/push_dir)
	return FALSE

/atom/movable/PushedBy(var/mob/pusher, var/mob/push_dir)
	if(flags & FLAG_ANCHORED)
		return FALSE
	glide_size = pusher.glide_size
	if(step_towards(src, get_step(src, push_dir)))
		if(move_sound)
			PlayLocalSound(src, move_sound, 50, frequency = -1)
		NotifyNearby("\The [pusher] pushes \the [src].")
		return TRUE
	return FALSE

/mob/PushedBy(var/mob/pusher, var/mob/push_dir)

	if(pusher.intent.selecting == INTENT_HARM)
		. = ..()
	else
		if(intent.selecting == INTENT_HARM)
			NotifyNearby("\The [pusher] tries to move past \the [src], but [They()] block[s()] [pusher.Them()].")
			pusher.next_move = world.time + max(1, round(pusher.GetMoveDelay()/2))
		else
			glide_size = pusher.glide_size
			var/pusher_loc = pusher.loc
			pusher.ForceMove(loc)
			ForceMove(pusher_loc)
			NotifyNearby("\The [pusher] moves past \the [src].")
		return TRUE

/mob/proc/NoDeadMove()
	return TRUE

/mob/GetMoveDelay()
	. = (loc ? loc.GetMoverDelay(src) : 0) + (walking ? walk_delay : run_delay)
	for(var/thing in active_grabs)
		var/obj/item/grab/grab = thing
		. += grab.grabbed.PullCost()
	if(prone)
		. += 3
	. += HandleStanceMoveDelay()

/mob/proc/Walk()
	walking = TRUE

/mob/proc/Run()
	walking = FALSE

/mob/SetDir(var/newdir)
	. = ..()
	TurnMob(newdir)
	UpdateVisionCone()

/mob/proc/TurnMob(var/newdir)
	var/matrix/M = matrix()
	M.Turn(dir2turn(newdir))
	transform = M

//code for controlling walk_dir is in /code/client/control.dm
/mob/proc/MoveLoop()
	set waitfor = 0
	while(client)
		if(loc && walk_dir)
			self_move = TRUE
			Move(get_step(src, walk_dir))
			self_move = FALSE
		WAIT_1T

/mob/Login()
	spawn()
		DoFadein(src, 10)
	. = ..()
	MoveLoop()
