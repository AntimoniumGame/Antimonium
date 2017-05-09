/obj
	icon = 'icons/objects/object.dmi'
	layer = ITEM_LAYER

/obj/left_clicked_on(var/mob/clicker)
	handle_clicked_on(clicker, BP_LEFT_HAND)

/obj/right_clicked_on(var/mob/clicker)
	handle_clicked_on(clicker, BP_RIGHT_HAND)

/obj/middle_clicked_on(var/mob/clicker)
	clicker << output("It's \a [name].", "chatoutput")

/obj/proc/handle_clicked_on(var/mob/clicker, var/slot)
	if(is_adjacent_to(get_turf(src), get_turf(clicker)))
		if(clicker.get_equipped(slot))
			attacked_by(clicker, clicker.get_equipped(slot))
		else
			manipulated_by(clicker, slot)

/obj/proc/attacked_by(var/mob/user, var/obj/item/thing)
	return

/obj/proc/manipulated_by(var/mob/user)
	return