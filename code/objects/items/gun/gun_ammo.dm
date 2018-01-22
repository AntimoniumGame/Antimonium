/obj/item/shot
	name = "shot"
	contact_size = 1
	weight = 1
	sharpness = 0
	icon = 'icons/objects/items/firearms/lead_shot.dmi'
	default_material_path = /datum/material/metal/lead

/obj/item/shot/EndThrow(var/throw_force)
	if(throw_force > 1) // Fired from a gun.
		QDel(src)
