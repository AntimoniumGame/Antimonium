/mob/proc/left_click_on(var/atom/thing, var/ctrl, var/alt)
	try_general_interaction(thing, ctrl, alt, SLOT_MOUTH, BP_HEAD)

/mob/proc/right_click_on(var/atom/thing, var/ctrl, var/alt)
	try_general_interaction(thing, ctrl, alt, SLOT_MOUTH, BP_HEAD)

/mob/proc/middle_click_on(var/atom/thing, var/ctrl, var/alt)
	if(!dead)
		face_atom(thing)
		thing.middle_clicked_on(src)

/mob/human/left_click_on(var/atom/thing, var/ctrl, var/alt)
	if(!try_general_interaction(thing, ctrl, alt, SLOT_LEFT_HAND, BP_LEFT_HAND))
		thing.left_clicked_on(src)

/mob/human/right_click_on(var/atom/thing, var/ctrl, var/alt)
	if(!try_general_interaction(thing, ctrl, alt, SLOT_RIGHT_HAND, BP_RIGHT_HAND))
		thing.right_clicked_on(src)

/mob/left_clicked_on(var/mob/clicker)
	handle_interaction(clicker, SLOT_LEFT_HAND)

/mob/right_clicked_on(var/mob/clicker)
	handle_interaction(clicker, SLOT_RIGHT_HAND)

/mob/proc/handle_interaction(var/mob/person, var/slot_id)
	if(!is_adjacent_to(get_turf(src), get_turf(person)))
		return
	if(person == src)
		handle_interaction_self(slot_id)
	else
		handle_interaction_other(person, slot_id)

/mob/proc/handle_interaction_other(var/mob/person, var/slot_id)
	if(on_combat_cooldown())
		return
	set_combat_cooldown(4)
	var/obj/item/prop = person.get_equipped(slot_id)
	if(prop)
		prop.attacking(person, src)
	else
		person.attack(src)

/mob/proc/handle_interaction_self(var/slot_id)
	if(on_combat_cooldown())
		return
	set_combat_cooldown(2)
	var/obj/item/prop = get_equipped(slot_id)
	if(prop)
		prop.attacking_self(src)
	else
		attack_self()

/mob/proc/attack_self()
	return

/mob/proc/attack(var/mob/target)
	if(on_combat_cooldown())
		return
	set_combat_cooldown(4)
	do_attack_animation(target)
	if(intent.selecting == INTENT_HELP)
		notify_nearby("\The [src] pokes \the [target].")
	else
		notify_nearby("\The [src] punches \the [target]!")
		play_local_sound(src, 'sounds/effects/punch1.wav', 40)
		target.resolve_physical_attack(src, 5, 0, 5, null)

/mob/proc/try_general_interaction(var/atom/thing, var/ctrl, var/alt, var/slot, var/limb)
	if(!dead && can_use_limb(limb))
		face_atom(thing)
		if(ctrl && thing.is_grabbable())
			grab_atom(thing, limb, slot)
			return TRUE
		else if(alt && (istype(thing, /turf) || istype(thing.loc, /turf)))
			var/obj/item/throwing = get_equipped(slot)
			if(throwing && throwing.throw_at(src, thing))
				return TRUE
	return FALSE
