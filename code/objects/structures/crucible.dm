/obj/structure/crucible
	name = "crucible"
	icon = 'icons/objects/structures/crucible.dmi'
	density = 1
	weight = 5
	default_material_path = /datum/material/stone/clay
	shadow_size = 3
	max_contains_count = 10
	max_contains_size_single = 5
	max_contains_size_total =  50
	open = TRUE

/obj/structure/crucible/ToggleOpen(var/mob/user, var/slot)
	return
