/mob/proc/left_click_on(var/atom/thing)
	thing.left_clicked_on(src)

/mob/proc/middle_click_on(var/atom/thing)
	thing.middle_clicked_on(src)

/mob/proc/right_click_on(var/atom/thing)
	thing.right_clicked_on(src)

/mob/left_clicked_on(var/mob/clicker)
	handle_interaction(clicker, "left_hand")

/mob/right_clicked_on(var/mob/clicker)
	handle_interaction(clicker, "right_hand")

/mob/middle_clicked_on(var/mob/clicker)
	return

/mob/proc/handle_interaction(var/mob/person, var/slot_id)
	if(!is_adjacent_to(get_turf(src), get_turf(person)))
		return
	if(person == src)
		handle_interaction_self(slot_id)
	else
		handle_interaction_other(person, slot_id)

/mob/proc/handle_interaction_other(var/mob/person, var/slot_id)
	var/obj/item/prop = get_equipped(slot_id)
	if(prop)
		prop.attacking(person, src)
	else
		person.attack(src)

/mob/proc/handle_interaction_self(var/slot_id)
	var/obj/item/prop = get_equipped(slot_id)
	if(prop)
		prop.attacking_self(src)
	else
		attack_self()

/mob/proc/attack_self()
	notify_nearby("\The [src] scratches \his head.")

/mob/proc/attack(var/mob/target)
	notify_nearby("\The [src] bonks \the [target] on the head with a closed fist.")
