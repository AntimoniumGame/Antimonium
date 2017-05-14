/obj/item/grab
	icon = 'icons/objects/items/grab.dmi'
	simulated = FALSE
	var/mob/human/owner
	var/atom/movable/grabbed

/obj/item/grab/New(var/mob/human/_owner, var/atom/movable/_grabbed)
	..(_owner)
	owner = _owner
	owner.active_grabs += src
	grabbed = _grabbed
	name = "grip on \the [grabbed]"
	processing_objects += src

/obj/item/grab/after_dropped()
	qdel(src)

/obj/item/grab/destroy()

	// I GIVE UP I'M HARDCODING THIS.
	if(owner)
		owner.active_grabs -= src
		for(var/invslot in owner.inventory_slots)
			var/obj/ui/inv/inv_slot = owner.inventory_slots[invslot]
			if(inv_slot.holding == src)
				inv_slot.forget_held()
				break
		owner.update_icon()

	grabbed = null
	owner = null
	processing_objects -= src
	. = ..()

/obj/item/grab/process()
	check_state()

/obj/item/grab/proc/check_state()
	if(!owner || loc != owner || !grabbed || !isturf(grabbed.loc) || !is_adjacent_to(grabbed, owner))
		qdel(src)
		return FALSE
	return TRUE

/obj/item/grab/throw_at(var/mob/thrower, var/atom/target)
	if(!thrower.on_combat_cooldown())
		thrower.set_combat_cooldown(4)
		thrower.notify_nearby("\The [thrower] hurls \the [grabbed]!")
		grabbed.thrown_at(target, thrower)
		qdel(src)
		return TRUE
	return FALSE
