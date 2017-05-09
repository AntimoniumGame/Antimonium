/*
Object interactions:
	attacked_by(var/mob/user, var/obj/item/thing) - The item is being attacked by user with thing.
	manipulated_by(var/mob/user, var/slot) -        The item is being attacked by user with empty inventory slot, slot.
*/

/obj
	icon = 'icons/objects/object.dmi'
	layer = ITEM_LAYER

/obj/left_clicked_on(var/mob/clicker)
	handle_clicked_on(clicker, BP_LEFT_HAND)

/obj/right_clicked_on(var/mob/clicker)
	handle_clicked_on(clicker, BP_RIGHT_HAND)

/obj/middle_clicked_on(var/mob/clicker)
	to_chat(clicker, "It's \a [name].")

/obj/proc/handle_clicked_on(var/mob/clicker, var/slot)
	if(is_adjacent_to(get_turf(src), get_turf(clicker)))
		if(clicker.get_equipped(slot))
			attacked_by(clicker, clicker.get_equipped(slot))
		else
			manipulated_by(clicker, slot)

/obj/proc/attacked_by(var/mob/user, var/obj/item/thing)
	return

/obj/proc/manipulated_by(var/mob/user, var/slot)
	return