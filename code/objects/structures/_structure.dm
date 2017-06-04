/obj/structure
	name = "structure"
	icon = 'icons/objects/structures/crate.dmi'
	density = 1
	default_material_path = /datum/material/metal/iron
	move_sound = 'sounds/effects/scrape1.ogg'
	shadow_size = 3

	var/weight = 3
	var/list/holding = list()
	var/hit_sound = 'sounds/effects/thump1.ogg'

/obj/structure/SetDir(var/newdir)
	..(newdir)
	if((flags & FLAG_SEATING) && loc)
		for(var/mob/mob in loc.contents)
			if(mob.sitting)
				mob.SetDir(dir)

/obj/structure/AttackedBy(var/mob/user, var/obj/item/prop)
	. = ..()
	if(!.)
		if((flags & FLAG_FLAT_SURFACE) && user.intent.selecting == INTENT_HELP && user.DropItem(prop))
			if(prop && !Deleted(prop)) //grabs
				ThingPlacedOn(user, prop)
				return TRUE

/obj/structure/proc/ThingPlacedOn(var/mob/user, var/obj/item/prop)
	prop.ForceMove(src.loc)
	if(user)
		user.NotifyNearby("<span class='notice'>\The [user] places \the [prop] on \the [src].</span>")

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
