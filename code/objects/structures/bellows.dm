/obj/structure/bellows
	name = "bellows"
	icon = 'icons/objects/structures/bellows.dmi'
	icon_state = "world"
	default_material_path = /datum/material/wood
	var/in_use = FALSE

/obj/structure/bellows/ManipulatedBy(var/mob/user)
	. = ..()
	if(!. && !in_use)
		in_use = TRUE
		flick("blow",src)
		NotifyNearby("\The [user] works \the [src]!")
		sleep(15)
		icon_state = "world"
		in_use = FALSE
