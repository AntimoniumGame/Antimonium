/atom/movable/proc/GetThrownAtom()
	return src

/atom/movable/proc/HandlePreThrow(var/mob/thrower)
	return thrower.DropItem(src)

/atom/movable/proc/HandlePostThrow()
	return

/atom/movable/proc/CheckThrowSuccess(var/mob/thrower)
	return prob(80)

/obj/item/proc/ThrowAt(var/mob/thrower, var/atom/target)
	if(!thrower.OnCombatCooldown() && HandlePreThrow(thrower))
		thrower.SetCombatCooldown(4)
		var/atom/movable/throwing = GetThrownAtom()
		thrower.NotifyNearby("<span class='alert'>\The [thrower] hurls \the [throwing]!</span>")
		thrower.DoAttackAnimation(target, throwing)
		if(!CheckThrowSuccess(thrower))
			var/atom/new_target = get_turf(target)
			new_target = get_step(new_target, pick(all_dirs))
			if(istype(new_target))
				target = new_target
		else
			target = get_turf(target)
		throwing.ThrownAt(target, thrower)
		HandlePostThrow()
		return TRUE
	return FALSE

// Grabs.
/obj/item/grab/GetThrownAtom()
	return grabbed

/atom/movable/grab/HandlePostThrow()
	QDel(src)

/obj/item/grab/HandlePreThrow(var/mob/thrower)
	if(grabbed.flags & FLAG_ANCHORED)
		return FALSE
	grabbed.ForceMove(get_turf(thrower))
	return TRUE

/obj/item/grab/CheckThrowSuccess(var/mob/thrower)
	return prob(50)

// Stacks.
/obj/item/stack/GetThrownAtom()
	return new type(get_turf(src), material ? material.type : default_material_path, 1)

/obj/item/stack/HandlePreThrow(var/mob/thrower)
	return TRUE

/obj/item/stack/HandlePostThrow()
	Remove(1)
