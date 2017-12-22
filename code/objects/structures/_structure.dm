/obj/structure
	name = "structure"
	icon = 'icons/objects/structures/crate.dmi'
	density = 1
	default_material_path = /datum/material/metal/iron
	move_sound = 'sounds/effects/scrape1.ogg'
	draw_shadow_underlay = TRUE

	var/weight = 3
	var/hit_sound = 'sounds/effects/thump1.ogg'
	max_damage = 50

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

/obj/structure/proc/ThingPlacedOn(var/mob/user, var/obj/item/prop, var/precise_placement = TRUE)
	prop.ForceMove(src.loc)
	if(user)
		user.NotifyNearby("<span class='notice'>\The [user] places \the [prop] on \the [src].</span>")
		if(user.client && precise_placement && istype(prop))
			prop.pixel_x = text2num(user.client.last_click["icon-x"])-16
			prop.pixel_y = text2num(user.client.last_click["icon-y"])-16
			return
	prop.RandomizePixelOffset()

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

/obj/structure/EndThrow()
	ResetPosition()

/obj/structure/TakeDamage(var/dam, var/source)
	damage = max(min(damage+dam, max_damage),0)
	if(damage == max_damage && !Deleted(src))
		Destroyed()
	..()

/obj/structure/proc/Destroyed()
	QDel(src, "destroyed")