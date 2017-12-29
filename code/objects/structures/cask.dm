/obj/structure/cask
	name = "cask"
	icon = 'icons/objects/structures/cask.dmi'
	icon_state = "flat"
	weight = 30
	default_material_path = /datum/material/wood
	density = 1
	max_reagent_volume = 200
	max_damage = 300
	var/initial_fill_type

/obj/structure/cask/Initialize()
	..()
	if(initial_fill_type && max_reagent_volume > 20)
		AddReagent(src, initial_fill_type, max_reagent_volume - 20) // Leave some room for contaminants.

/obj/structure/cask/water
	name = "cask of water"
	initial_fill_type = /datum/material/water

/obj/structure/cask/beer
	name = "cask of beer"
	initial_fill_type = /datum/material/water/alcohol

/obj/structure/cask/wine
	name = "cask of wine"
	initial_fill_type =  /datum/material/water/alcohol/wine

/obj/structure/cask/ManipulatedBy(var/mob/user, var/slot)
	. = ..()
	if(!.)
		if(user.loc != src.loc && user.intent.selecting == INTENT_HELP && !(flags & FLAG_ANCHORED))
			SetDir(turn(dir, 90))
			return TRUE
	return FALSE

/obj/structure/barrel
	name = "barrel"
	icon = 'icons/objects/structures/barrel.dmi'
	max_contains_count =       8
	max_contains_size_single = 50
	max_contains_size_total =  80
	icon_state = "closed"
	max_damage = 500

/obj/structure/barrel/UpdateIcon()
	icon_state = "[open ? "open" : "closed"]"
	..()

/obj/structure/barrel/ManipulatedBy(var/mob/user, var/slot)
	. = ..()
	if(!.)
		if(user.loc != src.loc && user.intent.selecting == INTENT_HELP && !(flags & FLAG_ANCHORED))
			SetDir(turn(dir, 90))
			return TRUE
	return FALSE
