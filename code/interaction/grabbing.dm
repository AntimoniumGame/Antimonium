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

/mob
	var/list/active_grabs = list()

/mob/proc/grab_atom(var/atom/movable/grabbing, var/grabbing_with, var/grabbing_slot)

	if(!is_adjacent_to(src, grabbing))
		return

	if(!can_use_limb(grabbing_with))
		return

	if(get_equipped(grabbing_slot))
		notify("You are already holding something there!")
		return

	for(var/obj/item/grab/grab in active_grabs)
		if(grab.grabbed == grabbing)
			notify("You already have a grip on \the [grabbing].")
			return

	var/obj/item/grab/grab = new(src, grabbing)
	collect_item(grab, grabbing_slot)
	var/obj/item/limb/limb = limbs[grabbing_with]
	play_local_sound(src, 'sounds/effects/whoosh1.wav', 75)
	notify_nearby("\The [grab.owner] grabs \the [grab.grabbed] with [grab.owner.their()] [limb.name]!")
	grab.owner.do_attack_animation(grab.grabbed)


