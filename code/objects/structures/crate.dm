/obj/structure/crate
	name = "crate"
	default_material_path = /datum/material/wood

/obj/structure/crate/AttackedBy(var/mob/user, var/obj/item/prop)
	. = ..()
	if(!. && user.DropItem(prop))
		if(prop && !Deleted(prop))
			prop.ForceMove(src)
			holding += prop
			user.NotifyNearby("\The [user] places \the [prop] into \the [src].")
			return TRUE

/obj/structure/crate/ManipulatedBy(var/mob/user, var/slot)
	. = ..()
	if(!.)
		if(holding.len)
			var/obj/item/thing = pick(holding)
			holding -= thing
			thing.ForceMove(get_turf(src))
			user.CollectItem(thing, slot)
			user.NotifyNearby("\The [user] rummages around in \the [src] and pulls out \a [thing].")
		else
			user.NotifyNearby("\The [user] rummages around in \the [src] but comes up empty handed.")
