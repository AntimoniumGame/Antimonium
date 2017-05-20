/obj/structure
	name = "structure"
	icon = 'icons/objects/structures/crate.dmi'
	density = 1
	default_material_path = /datum/material/iron
	move_sound = 'sounds/effects/scrape1.wav'

	var/weight = 3
	var/list/holding = list()
	var/hit_sound = 'sounds/effects/thump1.wav'

/obj/structure/UpdateStrings()
	if(material)
		name = "[material.GetDescriptor()] [initial(name)]"
	else
		name = initial(name)

/obj/structure/UpdateValues()
	weight *= material.weight_modifier

/obj/structure/PullCost()
	return GetWeight()

/obj/structure/GetWeight()
	return weight
