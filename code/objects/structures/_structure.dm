/obj/structure
	name = "structure"
	icon = 'icons/objects/structures/crate.dmi'
	density = 1
	default_material_path = /datum/material
	move_sound = 'sounds/effects/scrape1.wav'

	var/weight = 3
	var/list/holding = list()
	var/hit_sound = 'sounds/effects/thump1.wav'

/obj/structure/update_strings()
	if(material)
		name = "[material.get_descriptor()] [initial(name)]"
	else
		name = initial(name)

/obj/structure/update_values()
	weight *= material.weight_modifier

/obj/structure/pull_cost()
	return weight
