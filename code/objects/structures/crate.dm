/obj/structure/crate
	name = "crate"
	default_material_path = /datum/material/wood

/obj/structure/crate/attacked_by(var/mob/user, var/obj/item/thing)
	user.drop_item(thing)
	thing.force_move(src)
	holding += thing
	user.notify_nearby("\The [user] places \the [thing] into \the [src].")

/obj/structure/crate/manipulated_by(var/mob/user, var/slot)
	if(holding.len)
		var/obj/item/thing = pick(holding)
		holding -= thing
		thing.force_move(get_turf(src))
		user.collect_item(thing, slot)
		user.notify_nearby("\The [user] rummages around in \the [src] and pulls out \a [thing].")
	else
		user.notify_nearby("\The [user] rummages around in \the [src] but comes up empty handed.")
