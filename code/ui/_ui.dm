/obj/ui
	name = ""
	plane = SCREEN_PLANE
	layer = 3
	screen_loc = "CENTER,CENTER"
	icon = 'icons/images/ui.dmi'
	var/mob/owner
	flags = FLAG_ANCHORED | FLAG_ETHEREAL

/obj/ui/destroy()
	if(owner)
		owner.ui_screen -= src
		if(owner.client)
			owner.client.screen -= src
		owner = null
	. = ..()

/obj/ui/New(var/mob/_owner)
	owner = _owner
	..(_owner)
	null_loc()
	verbs.Cut()
	owner.ui_screen += src
	if(owner.client)
		center(owner.client.view_x, owner.client.view_y)

/obj/ui/update_icon()
	..()
	if(owner && owner.client)
		center(owner.client.view_x, owner.client.view_y)

// Override the root objects since this is an abstract object of sorts.
/obj/ui/left_clicked_on(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	return (clicker == owner)

/obj/ui/right_clicked_on(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	return (clicker == owner)

/obj/ui/middle_clicked_on(var/mob/clicker)
	return (clicker == owner)

/obj/ui/proc/center(var/center_x, var/center_y)
	return

/obj/ui/proc/report_window_closed()
	return
