/obj/item
	name = "item"
	icon_state = "world"
	icon = 'icons/objects/items/_default.dmi'

/obj/item/New()
	. = ..()

/obj/item/proc/use(var/mob/user)
	return

/obj/item/proc/get_worn_icon(var/inventory_slot)
	return image(icon = icon, icon_state = inventory_slot)

/obj/item/proc/get_inv_icon()
	return get_worn_icon("held")

/obj/item/left_clicked_on(var/mob/clicker)
	clicker.collect_item(src, "left_hand")

/obj/item/right_clicked_on(var/mob/clicker)
	clicker.collect_item(src, "right_hand")

/obj/item/middle_clicked_on(var/mob/clicker)
	clicker << "It's \a [name]."

/obj/item/proc/attacking(var/mob/user, var/mob/target)
	user.notify_nearby("\The [user] bonks \the [target] over the head with \the [src].")

/obj/item/proc/attacking_self(var/mob/user)
	user.notify_nearby("\The [user] scratches \his back with \the [src].")
