/obj/item/clothing
	name_prefix = "rough"
	default_material_path = /datum/material/cloth
	collect_sound = 'sounds/effects/rustle1.ogg'
	var/dyed = WHITE
	var/list/colour_to_icon

/obj/item/clothing/proc/SetDyed(var/_dyed = WHITE)
	dyed = _dyed
	if(colour_to_icon && !isnull(colour_to_icon[dyed]))
		icon = colour_to_icon[dyed]
	else
		icon = initial(icon)
