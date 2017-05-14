/obj/item/proc/throw_at(var/mob/thrower, var/atom/target)
	if(!thrower.on_combat_cooldown() && thrower.drop_item(src))
		thrower.set_combat_cooldown(4)
		thrower.notify_nearby("\The [thrower] hurls \the [src]!")
		thrown_at(target, thrower)
		return TRUE
	return FALSE

/obj/item/grab/throw_at(var/mob/thrower, var/atom/target)
	if(!thrower.on_combat_cooldown())
		thrower.set_combat_cooldown(4)
		thrower.notify_nearby("\The [thrower] hurls \the [grabbed]!")
		grabbed.thrown_at(target, thrower)
		qdel(src)
		return TRUE
	return FALSE
