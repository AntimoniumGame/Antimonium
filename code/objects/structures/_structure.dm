/obj/structure
	name = "structure"
	icon = 'icons/objects/structures/crate.dmi'
	density = 1
	default_material_path = /datum/material/metal/iron
	move_sound = 'sounds/effects/scrape1.wav'

	var/weight = 3
	var/list/holding = list()
	var/hit_sound = 'sounds/effects/thump1.wav'

/obj/structure/attacked_by(var/mob/user, var/obj/item/thing)
	. = ..()
	if(!.)
		if((flags & FLAG_FLAT_SURFACE) && user.intent.selecting == INTENT_HELP && user.drop_item(thing))
			if(thing && !deleted(thing)) //grabs
				thing.force_move(src.loc)
				user.notify_nearby("\The [user] places \the [thing] on \the [src].")
				return TRUE

/obj/structure/update_strings()
	if(material)
		name = "[material.get_descriptor()] [initial(name)]"
	else
		name = initial(name)

/obj/structure/update_values()
	weight = initial(weight)
	if(material)
		weight *= material.weight_modifier

/obj/structure/pull_cost()
	return get_weight()

/obj/structure/get_weight()
	return weight
