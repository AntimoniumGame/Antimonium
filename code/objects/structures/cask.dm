/obj/structure/cask
	name = "cask"
	icon = 'icons/objects/structures/cask.dmi'
	icon_state = "flat"
	weight = 30
	default_material_path = /datum/material/wood
	shadow_size = 3
	density = 1

/obj/structure/cask/ManipulatedBy(var/mob/user, var/slot)
	. = ..()
	if(!.)
		if(user.loc != src.loc && user.intent.selecting == INTENT_HELP && !(flags & FLAG_ANCHORED))
			user.NotifyNearby("\The [user] turns \the [src] around.")
			SetDir(turn(dir, 90))
			return TRUE
	return FALSE

/obj/structure/cask/barrel
	name = "barrel"
	icon = 'icons/objects/structures/barrel.dmi'
	max_contains_count =       8
	max_contains_size_single = 50
	max_contains_size_total =  80
	icon_state = "closed"

/obj/structure/cask/barrel/UpdateIcon(var/list/supplied = list())
	. = ..(supplied)
	icon_state = "[open ? "open" : "closed"]"

