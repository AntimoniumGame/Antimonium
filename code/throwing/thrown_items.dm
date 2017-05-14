/obj/item/proc/throw_at(var/mob/thrower, var/atom/target)
	if(!thrower.on_combat_cooldown() && thrower.drop_item(src))
		thrower.set_combat_cooldown(4)
		thrower.notify_nearby("\The [thrower] hurls \the [src]!")
		if(prob(30))
			var/atom/new_target = get_turf(target)
			new_target = get_step(new_target, pick(all_dirs))
			if(istype(new_target))
				target = new_target
		thrown_at(target, thrower)
		return TRUE
	return FALSE

/obj/item/grab/throw_at(var/mob/thrower, var/atom/target)
	if(!thrower.on_combat_cooldown())
		thrower.set_combat_cooldown(4)
		thrower.notify_nearby("\The [thrower] hurls \the [grabbed]!")
		if(prob(60))
			var/atom/new_target = get_turf(target)
			new_target = get_step(new_target, pick(all_dirs))
			if(istype(new_target))
				target = new_target
		grabbed.thrown_at(target, thrower)
		qdel(src)
		return TRUE
	return FALSE
