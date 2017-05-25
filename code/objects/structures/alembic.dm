/obj/structure/alembic
	name = "alembic"
	icon = 'icons/objects/structures/alembic.dmi'
	icon_state = "map"
	flags = FLAG_SIMULATED
	default_material_path = /datum/material/stone/glass

obj/structure/alembic/UpdateIcon(var/list/supplied = list())
	icon_state = "world"
	supplied += image(icon = icon, icon_state = "alembic")
	. = ..(supplied)
