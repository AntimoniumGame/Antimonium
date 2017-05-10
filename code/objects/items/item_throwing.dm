/obj/item/proc/throw_at(var/mob/thrower, var/atom/target)
	if(thrower.drop_item(src))
		thrower.notify_nearby("\The [thrower] hurls \the [src] at \the [target]!")
		move_to(get_turf(target))
		return TRUE
	return FALSE