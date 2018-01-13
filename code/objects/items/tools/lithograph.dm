/obj/item/lithograph
	name = "lithograph"
	icon = 'icons/objects/items/lithograph.dmi'
	default_material_path = /datum/material/metal/brass
	occupies_two_hands = TRUE

/obj/item/lithograph/GetWornIcon(var/inventory_slot)
	if(inventory_slot != SLOT_LEFT_HAND && inventory_slot != SLOT_RIGHT_HAND)
		return ..()
	return image(icon = icon, icon_state = "world") // no offsets or transforms.
