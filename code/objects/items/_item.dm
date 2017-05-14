/obj/item
	name = "item"
	icon_state = "world"
	icon = 'icons/objects/items/_default.dmi'

	var/slot_flags = 0
	var/contact_size = 1
	var/weight = 1
	var/sharpness = 1
	var/list/attack_verbs = list("bashes")
	var/name_prefix

	var/hit_sound = 'sounds/effects/punch1.wav'
	var/collect_sound = 'sounds/effects/click1.wav'
	var/equip_sound = 'sounds/effects/rustle1.wav'

/obj/item/update_values()
	sharpness = initial(sharpness)
	weight =    initial(weight)
	if(material)
		sharpness *= material.get_sharpness_mod()
		weight    *= material.get_weight_mod()

/obj/item/update_strings()
	if(material)
		if(name_prefix)
			name = "[name_prefix] [material.get_descriptor()] [initial(name)]"
		else
			name = "[material.get_descriptor()] [initial(name)]"
	else
		if(name_prefix)
			name = "[name_prefix] [initial(name)]"
		else
			name = "[initial(name)]"

/obj/item/proc/use(var/mob/user)
	return

/obj/item/proc/get_worn_icon(var/inventory_slot)
	return image(icon = icon, icon_state = inventory_slot)

/obj/item/proc/get_prone_worn_icon(var/inventory_slot)
	return image(icon = icon, icon_state = "prone_[inventory_slot]")

/obj/item/proc/get_inv_icon()
	return get_worn_icon("held")
