/mob/proc/left_click_on(var/atom/thing, var/ctrl, var/alt)
	if(dead)
		return
	face_atom(thing)
	thing.left_clicked_on(src)

/mob/proc/middle_click_on(var/atom/thing, var/ctrl, var/alt)
	if(dead)
		return
	face_atom(thing)
	thing.middle_clicked_on(src)

/mob/proc/right_click_on(var/atom/thing, var/ctrl, var/alt)
	if(dead)
		return
	face_atom(thing)
	thing.right_clicked_on(src)

/mob/left_clicked_on(var/mob/clicker)
	handle_interaction(clicker, BP_LEFT_HAND)

/mob/right_clicked_on(var/mob/clicker)
	handle_interaction(clicker, BP_RIGHT_HAND)

/mob/middle_clicked_on(var/mob/clicker)
	clicker.notify("[(src != clicker) ? "That's" : "You're"] \a [src].")

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
	set_combat_cooldown(8)
	var/obj/item/prop = person.get_equipped(slot_id)
	if(prop)
		prop.attacking(person, src)
	else
		person.attack(src)

/mob/proc/handle_interaction_self(var/slot_id)
	if(on_combat_cooldown())
		return
	set_combat_cooldown(5)
	var/obj/item/prop = get_equipped(slot_id)
	if(prop)
		prop.attacking_self(src)
	else
		attack_self()

/mob/proc/attack_self()
	if(on_combat_cooldown())
		return
	set_combat_cooldown(5)
	notify_nearby("\The [src] scratches \his head.")

/mob/proc/attack(var/mob/target)
	if(on_combat_cooldown())
		return
	set_combat_cooldown(8)
	if(intent.selecting == INTENT_HELP)
		notify_nearby("\The [src] pokes \the [target].")
	else
		notify_nearby("\The [src] punches \the [target]!")
		target.resolve_physical_attack(src, 5, 0, 5, null)
