/obj/structure/gaslamp
	name = "gas lamp"
	icon = 'icons/objects/structures/gaslamp.dmi'
	icon_state = "off"
	flags = FLAG_SIMULATED | FLAG_ANCHORED
	var/lit = FALSE

/obj/structure/gaslamp/ManipulatedBy(var/mob/user, var/slot)
	. = ..()
	if(!.)
		lit = !lit
		UpdateIcon()
		NotifyNearby("<span class='notice'>\The [user] [lit ? "lights" : "extinguishes"] \the [src].</span>")

/obj/structure/gaslamp/UpdateIcon()
	..()
	icon_state = lit ? "on" : "off"
