/atom/movable/proc/get_thrown_atom()
	return src

/atom/movable/proc/handle_pre_throw(var/mob/thrower)
	return thrower.drop_item(src)

/atom/movable/proc/handle_post_throw()
	return

/atom/movable/proc/check_throw_success(var/mob/thrower)
	return prob(80)

/obj/item/proc/throw_at(var/mob/thrower, var/atom/target)
	if(!thrower.on_combat_cooldown() && handle_pre_throw(thrower))
		thrower.set_combat_cooldown(4)
		var/atom/movable/throwing = get_thrown_atom()
		thrower.notify_nearby("\The [thrower] hurls \the [throwing]!")
		thrower.do_attack_animation(target, throwing)
		if(!check_throw_success(thrower))
			var/atom/new_target = get_turf(target)
			new_target = get_step(new_target, pick(all_dirs))
			if(istype(new_target))
				target = new_target
		else
			target = get_turf(target)
		throwing.thrown_at(target, thrower)
		handle_post_throw()
		return TRUE
	return FALSE

// Grabs.
/obj/item/grab/get_thrown_atom()
	return grabbed

/atom/movable/grab/handle_post_throw()
	qdel(src)

/obj/item/grab/handle_pre_throw(var/mob/thrower)
	if(grabbed.flags & FLAG_ANCHORED)
		return FALSE
	grabbed.force_move(get_turf(thrower))
	return TRUE

/obj/item/grab/check_throw_success(var/mob/thrower)
	return prob(50)

// Stacks.
/obj/item/stack/get_thrown_atom()
	return new type(get_turf(src), material.type, 1, src)

/obj/item/stack/handle_pre_throw(var/mob/thrower)
	return TRUE

/obj/item/stack/handle_post_throw()
	remove(1)
