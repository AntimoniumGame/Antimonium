/obj/item
	name = "item"
	icon_state = "world"
	icon = 'icons/objects/items/_default.dmi'

/obj/item/proc/get_worn_icon(var/inventory_slot)
	return image(icon = icon, icon_state = inventory_slot)

/obj/item/proc/get_held_icon()
	return get_worn_icon("held")
