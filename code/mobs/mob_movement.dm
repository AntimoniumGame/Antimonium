/mob
	var/next_move = 0
	var/walking = TRUE
	var/walk_delay = 2
	var/run_delay = 1

/mob/can_move()
	return (dragged || (world.time >= next_move))

/mob/Move()

	if(no_dead_move() && dead && !dragged)
		return FALSE

	// Make sure we still have active grabs before moving the grabbed.
	for(var/thing in active_grabs)
		var/obj/item/grab/grab = thing
		// If the grab persists, move whatever they're dragging.
		if(istype(grab))
			grab.check_state()

	var/last_loc = loc

	. = ..()

	if(.)

		// Move anything we're dragging a step towards us.
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

		next_move = world.time + get_move_delay()
		update_vision_cone()
		for(var/mob/M in viewers(world.view, get_turf(src)))
			if(M.client)
				M.update_vision_cone()

/mob/Bump(var/atom/movable/obstacle)
	if(obstacle.pushed_by(src, dir))
		next_move = world.time + max(1, get_move_delay() + round(obstacle.pull_cost()/2))

/atom/proc/pushed_by(var/mob/pusher, var/mob/push_dir)
	return FALSE

/atom/movable/pushed_by(var/mob/pusher, var/mob/push_dir)
	glide_size = pusher.glide_size
	if(step_towards(src, get_step(src, push_dir)))
		if(move_sound)
			play_local_sound(src, move_sound, 20, frequency = -1)
		notify_nearby("\The [pusher] pushes \the [src].")
	return TRUE

/mob/pushed_by(var/mob/pusher, var/mob/push_dir)

	if(pusher.intent.selecting == INTENT_HARM)
		. = ..()
	else
		if(intent.selecting == INTENT_HARM)
			notify_nearby("\The [pusher] tries to move past \the [src], but [they()] block[s()] [pusher.them()].")
			pusher.next_move = world.time + max(1, round(pusher.get_move_delay()/2))
		else
			glide_size = pusher.glide_size
			var/pusher_loc = pusher.loc
			pusher.force_move(loc)
			force_move(pusher_loc)
			notify_nearby("\The [pusher] moves past \the [src].")
		return TRUE

/mob/proc/no_dead_move()
	return TRUE

/mob/get_move_delay()
	. = (loc ? loc.get_mover_delay(src) : 0) + (walking ? walk_delay : run_delay)
	for(var/thing in active_grabs)
		var/obj/item/grab/grab = thing
		. += grab.grabbed.pull_cost()
	if(prone)
		. += 3
	. += handle_stance_move_delay()

/mob/proc/Walk()
	walking = TRUE

/mob/proc/Run()
	walking = FALSE

/mob/set_dir(var/newdir)
	. = ..()
	turn_mob(newdir)
	update_vision_cone()

/mob/proc/turn_mob(var/newdir)
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
		do_fadein(src, 10)
	. = ..()
	MoveLoop()

/mob/handle_dragged(var/turf/from_turf, var/turf/to_turf)
	if(prone)
		..()
		for(var/thing in injured_limbs)
			var/obj/item/limb/limb = thing
			if(limb.is_bleeding())
				blood_smear(src, from_turf, to_turf)
				return
