/obj/structure/alembic
	name = "alembic"
	icon = 'icons/objects/structures/alembic.dmi'
	icon_state = "map"
	flags = FLAG_SIMULATED
	default_material_path = /datum/material/stone/glass
	max_reagent_volume = 20
	precise_reagent_transfer = TRUE

	var/image/alembic_overlay	// the glass bit

/obj/structure/alembic/New()
	alembic_overlay = image(icon = icon, icon_state = "alembic")
	..()

/obj/structure/alembic/UpdateIcon()
	icon_state = "world"
	overlays -= alembic_overlay
	..()
	overlays += alembic_overlay
