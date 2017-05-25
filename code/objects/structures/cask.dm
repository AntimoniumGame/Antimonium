/obj/structure/cask/barrel
	name = "barrel"
	icon = 'icons/objects/structures/barrel.dmi'

/obj/structure/cask
	name = "cask"
	icon = 'icons/objects/structures/cask.dmi'
	icon_state = "flat"
	weight = 30
	default_material_path = /datum/material/wood
	shadow_size = 3
	density = 1

/obj/structure/cask/ManipulatedBy(var/mob/user)
	. = ..()
	if(!.)
		if(user.intent.selecting == INTENT_HELP && !(flags & FLAG_ANCHORED))
			user.NotifyNearby("\The [user] turns \the [src] around.")
			SetDir(turn(dir, 90))
			return TRUE
