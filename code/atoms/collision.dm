/atom
	density = 1
	var/collision_layer = COLLIDE_WORLD //what collision layer(s) this object's bounding area counts as.

/atom/movable
	var/collision_mask = COLLIDE_ALL //what the movable collides with.

//mobs collide with the world (solid turfs), and other mobs
/mob
	collision_layer = COLLIDE_MOBS
	collision_mask = (COLLIDE_WORLD | COLLIDE_MOBS | COLLIDE_STRUCTURES)

//objects collide with the world, and mobs
/obj
	collision_layer = COLLIDE_OBJECTS
	collision_mask = (COLLIDE_WORLD | COLLIDE_MOBS | COLLIDE_STRUCTURES)

//structures collide with everything
/obj/structure
	collision_layer = COLLIDE_STRUCTURES

//nothing collides with the floor
/turf
	collision_layer = COLLIDE_NONE

//everything collides with the walls
/turf/wall
	collision_layer = COLLIDE_ALL

//MOVEMENT HACK
//If both the turf and object crossing it are dense, yet dont share any collision channels, the standard byond behaviour
// will stop the movement. This overrides the density to allow the object to pass as long as they dont share a collision channel.
/turf/Enter(atom/movable/o, atom/oldloc)
	if(density && o.density)
		if(!(collision_layer & o.collision_mask))
			density = 0 //fool the engine into thinking that this turf isn't dense
			. = ..()
			density = 1 //...and back to normal
			return .
	return ..()
//END HACK

/area/Enter(atom/movable/o, atom/oldloc)
	return o.on_enter(src, !(density && o.density && o.collision_mask & collision_layer))
