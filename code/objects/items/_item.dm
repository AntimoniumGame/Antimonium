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
	var/associated_skill

	var/hit_sound = 'sounds/effects/punch1.wav'
	var/collect_sound = 'sounds/effects/click1.wav'
	var/equip_sound = 'sounds/effects/rustle1.wav'

/obj/item/GetWeight()
	return weight

/obj/item/UpdateValues()
	sharpness = initial(sharpness)
	weight =    initial(weight)
	if(material)
		sharpness *= material.GetSharpnessMod()
		weight    *= material.GetWeightMod()

/obj/item/UpdateStrings()
	if(material)
		if(name_prefix)
			name = "[name_prefix] [material.GetDescriptor()] [initial(name)]"
		else
			name = "[material.GetDescriptor()] [initial(name)]"
	else
		if(name_prefix)
			name = "[name_prefix] [initial(name)]"
		else
			name = "[initial(name)]"

/obj/item/proc/Use(var/mob/user)
	return

/obj/item/proc/GetWornIcon(var/inventory_slot)
	return image(icon = icon, icon_state = inventory_slot)

/obj/item/proc/GetProneWornIcon(var/inventory_slot)
	return image(icon = icon, icon_state = "prone_[inventory_slot]")

/obj/item/proc/GetInvIcon()
	return GetWornIcon("held")

/obj/item/Destroy()
	var/mob/owner = loc
	if(istype(owner))
		owner.DropItem(src)
	. = ..()

/obj/item/GetAmount()
	return initial(weight)
