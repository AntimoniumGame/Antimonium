/obj/item/shot
	name = "shot"
	edged = TRUE
	icon = 'icons/objects/items/firearms/lead_shot.dmi'
	default_material_path = /datum/material/metal/lead

/obj/item/shot/EndThrow(var/meters_per_second)
	if(meters_per_second > 1) // Fired from a gun.
		QDel(src)
