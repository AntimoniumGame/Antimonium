/mob/proc/left_click_on(var/atom/thing, var/ctrl, var/alt)
	if(!try_general_interaction(thing, ctrl, alt, SLOT_MOUTH, BP_HEAD))
		thing.left_clicked_on(src, SLOT_MOUTH)

/mob/proc/right_click_on(var/atom/thing, var/ctrl, var/alt)
	if(!try_general_interaction(thing, ctrl, alt, SLOT_MOUTH, BP_HEAD))
		thing.left_clicked_on(src, SLOT_MOUTH)

/mob/proc/middle_click_on(var/atom/thing, var/ctrl, var/alt)
	if(!dead)
		face_atom(thing)
		thing.middle_clicked_on(src)

/mob/human/left_click_on(var/atom/thing, var/ctrl, var/alt)
	if(!try_general_interaction(thing, ctrl, alt, SLOT_LEFT_HAND, BP_LEFT_HAND))
		thing.left_clicked_on(src, SLOT_LEFT_HAND)

/mob/human/right_click_on(var/atom/thing, var/ctrl, var/alt)
	if(!try_general_interaction(thing, ctrl, alt, SLOT_RIGHT_HAND, BP_RIGHT_HAND))
		thing.right_clicked_on(src, SLOT_RIGHT_HAND)

/mob/left_clicked_on(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	handle_interaction(clicker, slot)

/mob/right_clicked_on(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	handle_interaction(clicker, slot)

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
	do_unarmed_attack(target)

/mob/proc/do_unarmed_attack(var/mob/target)
	do_attack_animation(target)
	if(intent.selecting == INTENT_HELP)
		do_passive_unarmed_interaction(target)
	else
		do_violent_unarmed_interaction(target)

/mob/proc/do_violent_unarmed_interaction(var/mob/target)
	notify_nearby("\The [src] punches \the [target]!")
	play_local_sound(src, 'sounds/effects/punch1.wav', 50)
	target.resolve_physical_attack(src, 5, 0, 5, null)

/mob/proc/do_passive_unarmed_interaction(var/mob/target)
	notify_nearby("\The [src] pokes \the [target].")

/mob/proc/try_general_interaction(var/atom/thing, var/ctrl, var/alt, var/slot, var/limb)
	if(!dead && can_use_limb(limb))
		face_atom(thing)
		if(ctrl && thing.is_grabbable() && thing != src)
			grab_atom(thing, limb, slot)
			return TRUE
		else if(alt && (istype(thing, /turf) || istype(thing.loc, /turf)))
			var/obj/item/limb/use_limb = limbs[limb]
			if(!use_limb.is_dextrous())
				return
			var/obj/item/throwing = get_equipped(slot)
			if(throwing && throwing.throw_at(src, thing))
				return TRUE
	return FALSE
