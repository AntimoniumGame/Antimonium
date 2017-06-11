/obj/structure/alembic
	name = "alembic"
	icon = 'icons/objects/structures/alembic.dmi'
	icon_state = "map"
	flags = FLAG_SIMULATED
	default_material_path = /datum/material/stone/glass

	var/image/alembic_overlay	// the glass bit

obj/structure/alembic/UpdateIcon()
	icon_state = "world"

	overlays -= alembic_overlay
	alembic_overlay += image(icon = icon, icon_state = "alembic")
	overlays += alembic_overlay
	..()
