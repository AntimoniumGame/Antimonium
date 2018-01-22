/obj/item/weapon/halberd
	name = "halberd"
	weight = 5
	sharpness = 3
	contact_size = 5
	icon = 'icons/objects/items/halberd.dmi'
	attack_verbs = list("hacks", "slashes")
	hit_sound = 'sounds/effects/wound1.ogg'
	occupies_two_hands = TRUE

/obj/item/weapon/halberd/GetWornIcon(var/inventory_slot)
	if(inventory_slot != SLOT_LEFT_HAND && inventory_slot != SLOT_RIGHT_HAND)
		return ..()
	return image(icon = icon, icon_state = (inventory_slot == SLOT_LEFT_HAND ? "inhand_left" : "inhand_right"))
