/obj/ui
	name = ""
	plane = SCREEN_PLANE
	screen_loc = "CENTER,CENTER"
	icon = 'icons/images/ui.dmi'
	var/mob/owner

/obj/ui/destroy()
	owner = null
	. = ..()

/obj/ui/New(var/mob/_owner)
	..()
	owner = _owner
	move_to(null)
	verbs.Cut()

/obj/ui/proc/clicked_on(var/mob/clicker)
	return (clicker == owner)
