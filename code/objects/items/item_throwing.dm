/obj/item/proc/throw_at(var/mob/thrower, var/atom/target)
	if(!thrower.on_combat_cooldown() && thrower.drop_item(src))
		thrower.set_combat_cooldown(4)
		thrower.notify_nearby("\The [thrower] hurls \the [src]!")
		thrown_at(target, thrower)
		return TRUE
	return FALSE