/obj/structure/crate
	name = "crate"
	default_material_path = /datum/material/wood
	max_contains_count =       10
	max_contains_size_single = 100
	max_contains_size_total =  100
	icon_state = "closed"
	max_damage = 500

/obj/structure/crate/UpdateIcon()
	icon_state = "[open ? "open" : "closed"]"
	..()

/obj/structure/crate/chest
	name = "chest"
	icon = 'icons/objects/structures/chest.dmi'
	max_contains_size_single = 60
	max_contains_size_total =  60
	max_damage = 1000
