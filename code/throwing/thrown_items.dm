/obj/item/proc/throw_at(var/mob/thrower, var/atom/target)
	if(!thrower.on_combat_cooldown() && thrower.drop_item(src))
		thrower.set_combat_cooldown(4)
		thrower.notify_nearby("\The [thrower] hurls \the [src]!")
		thrower.do_attack_animation(target, src)
		if(prob(20))
			var/atom/new_target = get_turf(target)
			new_target = get_step(new_target, pick(all_dirs))
			if(istype(new_target))
				target = new_target
		thrown_at(target, thrower)
	return TRUE

/obj/item/grab/throw_at(var/mob/thrower, var/atom/target)
	if(!thrower.on_combat_cooldown())
		thrower.set_combat_cooldown(4)
		thrower.notify_nearby("\The [thrower] hurls \the [grabbed]!")
		thrower.do_attack_animation(target, grabbed)
		if(prob(60))
			var/atom/new_target = get_turf(target)
			new_target = get_step(new_target, pick(all_dirs))
			if(istype(new_target))
				target = new_target
		grabbed.thrown_at(target, thrower)
		qdel(src)
	return TRUE

/obj/item/stack/throw_at(var/mob/thrower, var/atom/target)
	if(!thrower.on_combat_cooldown())
		thrower.set_combat_cooldown(4)
		var/obj/item/stack/throwing = new type(get_turf(thrower), material.type, 1, src)
		thrower.notify_nearby("\The [thrower] hurls \the [throwing]!")
		thrower.do_attack_animation(target, throwing)
		if(prob(20))
			var/atom/new_target = get_turf(target)
			new_target = get_step(new_target, pick(all_dirs))
			if(istype(new_target))
				target = new_target
		throwing.thrown_at(target, thrower)
		remove(1)
	return TRUE
