/obj/structure
	name = "structure"
	icon = 'icons/objects/structures/crate.dmi'
	density = 1
	default_material_path = /datum/material/metal/iron
	move_sound = 'sounds/effects/scrape1.wav'
	shadow_size = 3

	var/weight = 3
	var/list/holding = list()
	var/hit_sound = 'sounds/effects/thump1.wav'

/obj/structure/AttackedBy(var/mob/user, var/obj/item/prop)
	. = ..()
	if(!.)
		if((flags & FLAG_FLAT_SURFACE) && user.intent.selecting == INTENT_HELP && user.DropItem(prop))
			if(prop && !Deleted(prop)) //grabs
				prop.ForceMove(src.loc)
				user.NotifyNearby("\The [user] places \the [prop] on \the [src].")
				return TRUE

/obj/structure/UpdateStrings()
	if(material)
		name = "[material.GetDescriptor()] [initial(name)]"
	else
		name = initial(name)

/obj/structure/UpdateValues()
	weight = initial(weight)
	if(material)
		weight *= material.weight_modifier

/obj/structure/PullCost()
	return GetWeight()

/obj/structure/GetWeight()
	return weight
