/obj/ui
	name = ""
	plane = SCREEN_PLANE
	layer = 3
	screen_loc = "CENTER,CENTER"
	icon = 'icons/images/ui.dmi'
	var/mob/owner
	interaction_flags = FLAG_ANCHORED | FLAG_ETHEREAL

/obj/ui/destroy()
	owner = null
	. = ..()

/obj/ui/New(var/mob/_owner)
	..(_owner)
	owner = _owner
	null_loc()
	verbs.Cut()

// Override the root objects since this is an abstract object of sorts.
/obj/ui/left_clicked_on(var/mob/clicker)
	return (clicker == owner)

/obj/ui/right_clicked_on(var/mob/clicker)
	return (clicker == owner)

/obj/ui/middle_clicked_on(var/mob/clicker)
	return (clicker == owner)

/obj/ui/proc/center(var/center_x, var/center_y)
	return
