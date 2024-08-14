/obj/item/clothing
	default_material_path = /datum/material/cloth
	collect_sound = 'sounds/effects/rustle1.ogg'

	var/dyed = WHITE
	var/list/colour_to_icon
	var/list/body_coverage
	var/list/alternate_icons
	var/list/mob_can_equip = list(/mob/human)
	var/thickness = 1

/obj/item/clothing/GetWornIcon(var/inventory_slot)
	var/mob/M = loc
	if(length(alternate_icons) && istype(M) && alternate_icons[M.type])
		icon = alternate_icons[M.type]
	else
		icon = initial(icon)
	. = ..()

/obj/item/clothing/Destroyed(var/dtype = WOUND_BRUISE)
	var/mob/M = loc
	if(istype(M))
		M.Notify("<span class='danger'>Your [src.name] falls apart!</span>")
		M.DropItem(src)
	..()

/obj/item/clothing/TakeDamage(var/dam, var/source, var/dtype = WOUND_BRUISE)
	. = ..()
	if(!Deleted(src))
		UpdateStrings()
		if(damage >= max_damage && damage <= (max_damage * 0.75))
			name = "mangled [name]"
		else if(damage >= (max_damage * 0.51) && damage <= (max_damage * 0.74))
			name = "battered [name]"
		else if(damage >= (max_damage * 0.26) && damage <= (max_damage * 0.5))
			name = "ragged [name]"
		else if(damage >= (max_damage * 0.05) && damage <= (max_damage * 0.25))
			name = "worn [name]"

/obj/item/clothing/New()
	..()
	if(!istype(body_coverage, /list)) body_coverage = list()

/obj/item/clothing/proc/SetDyed(var/_dyed = WHITE)
	dyed = _dyed
	if(colour_to_icon && !isnull(colour_to_icon[dyed]))
		icon = colour_to_icon[dyed]
	else
		icon = initial(icon)

/obj/item/clothing/proc/GetThickness()
	return thickness