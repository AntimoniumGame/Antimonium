/obj/structure/chair
	name = "chair"
	icon = 'icons/objects/structures/chair.dmi'
	density = 0
	icon_state = "wooden_chair"
	weight = 10
	default_material_path = /datum/material/wood
	flags = FLAG_SIMULATED | FLAG_SEATING

/obj/structure/chair/ManipulatedBy(var/mob/user, var/slot)
	. = ..()
	if(!.)
		if(user.loc != src.loc && user.intent.selecting == INTENT_HELP && !(flags & FLAG_ANCHORED))
			user.NotifyNearby("\The [user] turns \the [src] around.", MESSAGE_VISIBLE)
			SetDir(turn(dir, 90))
			return TRUE
	return FALSE

/obj/structure/chair/comfy
	icon_state = "felted_chair"
	default_material_path = /datum/material/cloth/felt