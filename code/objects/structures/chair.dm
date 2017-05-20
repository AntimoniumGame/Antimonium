/obj/structure/chair
	name = "chair"
	icon = 'icons/objects/structures/chair.dmi'
	density = 0
	icon_state = "wooden_chair"
	weight = 10
	default_material_path = /datum/material/wood

/obj/structure/chair/ManipulatedBy(var/mob/user)
	if(user.intent.selecting == INTENT_HELP && !(flags & FLAG_ANCHORED))
		user.NotifyNearby("\The [user] turns \the [src] around.")
		SetDir(turn(dir, 90))
	else
		..()

/obj/structure/chair/comfy
	icon_state = "felted_chair"
	default_material_path = /datum/material/cloth/felt