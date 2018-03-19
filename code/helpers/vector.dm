/vector
	var/atom/movable/owner
	var/coord_x           // current x location (in pixel coordinates)
	var/coord_y           // current y location (in pixel coordinates)
	var/inc_x             // x increment per step
	var/inc_y             // y increment per step
	var/move_delay        // ticks between each move
	var/pixel_speed       // speed in pixels per tick
	var/initial_pixel_x   // initial owner pixel_x offset
	var/initial_pixel_y   // initial owner pixel_y offset
	var/turf/target_turf  // destination
	var/spin_counter = -1 // spinning iterator
	var/supplied_throw_force = 1

/*
Inputs:
	source = the atom being moved along the vector
	start = the starting location
	end = the target location (currently only used for calculating the vector direction)
	speed = distance travelled in turfs-per-second
	xo = pixel_x offset of the target location (optional)
	yo = pixel_y offset of the target location (optional)
*/
/vector/New(atom/movable/source, start, end, speed = 20, xo = 16, yo = 16, spin = TRUE, var/throw_force = 1)
	_glob.vector_list += src
	owner = source
	initial_pixel_y = source.pixel_y
	initial_pixel_y = source.pixel_y
	supplied_throw_force = throw_force

	if(!start) start = get_turf(source)
	var/turf/src_turf = get_turf(start)
	target_turf = get_turf(end)

	owner.dragged = TRUE
	owner.ForceMove(src_turf)

	//convert to pixel coordinates
	var/start_loc_x = src_turf.x * TILE_WIDTH + (TILE_WIDTH / 2)
	var/start_loc_y = src_turf.y * TILE_HEIGHT + (TILE_HEIGHT / 2)

	var/target_loc_x = target_turf.x * TILE_WIDTH + xo
	var/target_loc_y = target_turf.y * TILE_HEIGHT + yo

	var/dist_x = target_loc_x - start_loc_x
	var/dist_y = target_loc_y - start_loc_y

	// avoiding a division by zero runtime
	if(dist_x == 0) dist_x = 1
	if(dist_y == 0) dist_y = 1

	//convert turfs-per-second to pixels-per-tick
	pixel_speed = (speed * TILE_WIDTH) / world.fps

	//first we work out how far we move each movement
	if(abs(dist_x) > abs(dist_y))
		//x is dominant direction
		inc_x = TILE_WIDTH * sign(dist_x)
		inc_y = (dist_y / dist_x) * inc_x //multiply the x increment by the y to x ratio
	else
		//y is the dominant direction
		inc_y = TILE_HEIGHT * sign(dist_y)
		inc_x = (dist_x / dist_y) * inc_y //multiply the y increment by the x to y ratio

	//now we work out how many ticks between each move
	var/inc_h = hypotenuse(inc_x, inc_y) //true pixel distance travelled for a full move
	move_delay = inc_h / pixel_speed //ticks between each move - floored so there will be some variation, but should be minor

	coord_x = start_loc_x
	coord_y = start_loc_y

	if(spin && (owner.flags & FLAG_THROWN_SPIN))
		spin_counter = 0
		owner.UpdateStrings()
		owner.name = "flying [owner.name]"

//call to kick off the vector movement
// allows the calling proc to continue and runs immediately after the parent proc sleeps or ends
/vector/proc/Initialize()
	set waitfor = 0

	while(owner)
		//increment our location in pixel space
		coord_x += inc_x
		coord_y += inc_y

		// The spinning x strikes the y in the z!
		if(spin_counter != -1)
			spin_counter++
			if(spin_counter >= 8) spin_counter = 0
			var/matrix/M = matrix()
			M.Turn(90 * round(spin_counter/2))
			owner.transform = M

		//convert our pixel space location to world coordinates and pixel offset
		var/world_x = coord_x / TILE_WIDTH
		var/loc_x = floor(world_x)
		var/pix_x = ((world_x - loc_x) * 32) - 16

		var/world_y = coord_y / TILE_WIDTH
		var/loc_y = floor(world_y)
		var/pix_y = ((world_y - loc_y) * 32) - 16

		var/turf/T = locate(loc_x, loc_y, owner.z)
		if(T && owner)
			owner.appearance_flags = LONG_GLIDE
			owner.glide_size = 32
			if((owner.loc == target_turf) || T.CheckThrownCollision(owner, supplied_throw_force) || !owner.Move(T))
				if(owner) // Somehow this is being nulled in an edge case.
					owner.dragged = FALSE
					owner.transform = null
					owner.UpdateIcon()
					owner.UpdateStrings()
					owner.EndThrow(supplied_throw_force)
					_glob.vector_list -= src
				return
			owner.pixel_x = pix_x
			owner.pixel_y = pix_y
		else
			_glob.vector_list -= src
			return

		WAIT_NT(move_delay)
	_glob.vector_list -= src
