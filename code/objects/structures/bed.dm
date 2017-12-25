/obj/structure/bed
	name = "bed"
	desc = "A hard wooden bed."
	icon = 'icons/objects/structures/bed.dmi'
	icon_state = "map"
	density = FALSE
	default_material_path = /datum/material/wood
	flags = FLAG_SIMULATED | FLAG_FLAT_SURFACE | FLAG_SEATING
	layer = TURF_LAYER
	var/image/sheet

/obj/structure/bed/UpdateIcon()
	..()
	var/list/removing_overlays = list("pillow")
	if(sheet) removing_overlays += sheet
	overlays -= removing_overlays
	sheet = image(icon, "sheet")
	sheet.layer = ITEM_LAYER + 0.1
	overlays += list("pillow", sheet)

/obj/structure/bed/AttackedBy(var/mob/user, var/obj/item/prop)
	if(istype(prop, /obj/item/grab))
		var/obj/item/grab/grab = prop
		if(ismob(grab.grabbed))
			var/mob/victim = grab.grabbed
			if(!victim.prone) victim.ToggleProne()
			victim.ForceMove(get_turf(src))
			victim.SetDir(turn(dir, 90))
			user.DropItem(prop)
			user.NotifyNearby("<span class='notice'>\The [user] tucks \the [victim] into \the [src].</span>")
			return TRUE
	. = ..()