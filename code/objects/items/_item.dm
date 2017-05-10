/*
Item interactions:
	attacking(var/mob/user, var/mob/target) -       The item is being used by user to attack target.
	attacking_self(var/mob/user) -                  The item is being used by user to attack user.
	attacked_by(var/mob/user, var/obj/item/thing) - The item is being attacked by user with thing.
*/

/obj/item
	name = "item"
	icon_state = "world"
	icon = 'icons/objects/items/_default.dmi'

	var/slot_flags = 0
	var/contact_size = 1
	var/weight = 1
	var/sharpness = 1
	var/list/attack_verbs = list("attacks")

/obj/item/proc/process()
	return

/obj/item/proc/use(var/mob/user)
	return

/obj/item/proc/get_worn_icon(var/inventory_slot)
	return image(icon = icon, icon_state = inventory_slot)

/obj/item/proc/get_prone_worn_icon(var/inventory_slot)
	return image(icon = icon, icon_state = "prone_[inventory_slot]")

/obj/item/proc/get_inv_icon()
	return get_worn_icon("held")

/obj/item/handle_clicked_on(var/mob/clicker, var/slot)
	if(is_adjacent_to(get_turf(src), get_turf(clicker)))
		if(!clicker.get_equipped(slot))
			notify_nearby("\The [clicker] picks up \the [src].")
			clicker.collect_item(src, slot)
			return
	. = ..()

/obj/item/proc/attacking(var/mob/user, var/mob/target)
	if(!simulated)
		return
	if(user.intent.selecting == INTENT_HELP)
		user.notify_nearby("\The [user] prods \the [target] with \the [src].")
	else
		user.notify_nearby("\The [user] [pick(attack_verbs)] \the [target] with \the [src]!")
		if(weight || sharpness)
			target.resolve_physical_attack(user, weight, sharpness, contact_size, src)

/obj/item/proc/attacking_self(var/mob/user)
	if(!simulated)
		return
	user.notify_nearby("\The [user] scratches \his back with \the [src].")

/obj/item/attacked_by(var/mob/user, var/obj/item/thing)
	if(!simulated)
		return
	user.notify_nearby("\The [user] pokes \the [src] with \the [thing].")

/obj/item/proc/before_dropped()
	return

/obj/item/proc/after_dropped()
	return

/obj/item/proc/before_picked_up()
	return

/obj/item/proc/after_picked_up()
	return
