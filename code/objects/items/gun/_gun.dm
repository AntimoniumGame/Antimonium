/obj/item/gun
	var/loaded

/obj/item/gun/GetWornIcon(var/inventory_slot)
	if(inventory_slot != SLOT_LEFT_HAND && inventory_slot != SLOT_RIGHT_HAND)
		return ..()
	return image(icon = icon, icon_state = (inventory_slot == SLOT_LEFT_HAND ? "inhand_left" : "inhand_right"))
