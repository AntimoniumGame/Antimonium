/obj/structure/crate
	name = "crate"
	default_material_path = /datum/material/wood
	max_contains_count =       10
	max_contains_size_single = 100
	max_contains_size_total =  100
	icon_state = "closed"

/obj/structure/crate/UpdateIcon(var/list/supplied = list())
	. = ..(supplied)
	icon_state = "[open ? "open" : "closed"]"
