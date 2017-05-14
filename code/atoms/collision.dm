var/list/movable_blockages = 0

/atom
	var/collision_layer = COLLIDE_WORLD //what collision layer(s) this object's bounding area counts as.

/atom/movable
	var/collision_mask = COLLIDE_ALL //what the movable collides with.



//MOVEMENT HACK
/turf/Enter(atom/movable/o, atom/oldloc)
	if(density && o.density)
		if(!(collision_layer & o.collision_mask))
			density = 0 //fool the engine into thinking that this turf isn't dense
			. = ..()
			density = 1 //tell it to you know, cut it out. wipe the value... with a cloth.
			return .
	return ..()
//END HACK

/area/Enter(atom/movable/o, atom/oldloc)
	return o.on_enter(src, !(density && o.density && o.collision_mask & collision_layer))
