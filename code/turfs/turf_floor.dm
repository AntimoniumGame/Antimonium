/turf/floor/
	icon_state = "1"
	var/diggable

/turf/floor/New()
	icon_state = pick(icon_states(icon))
	..()

/turf/floor/AttackedBy(var/mob/user, var/obj/item/prop)
	if(diggable && istype(prop, /obj/item/weapon/shovel))
		DigEarthworks(user)
		return TRUE
	. = ..()

/turf/floor/ManipulatedBy(var/mob/user, var/slot)
	if(diggable && user.IsDigger())
		DigEarthworks(user, slot)
		return TRUE
	. = ..()

/turf/floor/proc/DigEarthworks(var/mob/user, var/slot)

	if(!user.CanUseInvSlot(slot))
		return FALSE

	if(locate(/obj/structure/earthworks) in src)
		user.Notify("There are already earthworks here. You will need to fill them in before digging.")
		return TRUE

	if(user.intent.selecting == INTENT_HELP && user.IsDigger(TRUE))
		user.NotifyNearby("\The [user] carefully tills the soil into a farm.")
		new /obj/structure/earthworks/farm(src)
	else
		user.NotifyNearby("\The [user] digs a long, deep pit.")
		new /obj/structure/earthworks/pit(src)

/turf/floor/wood
	name = "wooden floor"
	icon = 'icons/turfs/wood_floor.dmi'

/turf/floor/stone
	name = "cobblestones"
	icon = 'icons/turfs/cobbles.dmi'

/turf/floor/dirt
	name = "dirt"
	icon = 'icons/turfs/dirt.dmi'
	diggable = TRUE

/turf/floor/grass
	name = "grass"
	icon = 'icons/turfs/grass.dmi'
	diggable = TRUE

/turf/floor/tiles
	name = "tiled floor"
	icon = 'icons/turfs/tiles.dmi'
	icon_state = "1"
