/obj/ui
	name = ""
	plane = UI_PLANE
	layer = 3
	screen_loc = "CENTER,CENTER"
	icon = 'icons/images/ui.dmi'
	var/mob/owner
	flags = FLAG_ANCHORED | FLAG_ETHEREAL
	appearance_flags = NO_CLIENT_COLOR

/obj/ui/Destroy()
	if(owner)
		owner.ui_screen -= src
		if(owner.client)
			owner.client.screen -= src
		owner = null
	. = ..()

/obj/ui/New(var/mob/_owner)
	owner = _owner
	..(_owner)
	NullLoc()
	verbs.Cut()
	owner.ui_screen += src
	if(owner.client)
		Center(owner.client.view_x, owner.client.view_y)

/obj/ui/UpdateIcon()
	if(owner && owner.client)
		Center(owner.client.view_x, owner.client.view_y)

// Override the root objects since this is an abstract object of sorts.
/obj/ui/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	return (clicker == owner)

/obj/ui/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	return (clicker == owner)

/obj/ui/MiddleClickedOn(var/mob/clicker)
	return (clicker == owner)

/obj/ui/proc/Center(var/center_x, var/center_y)
	return

/obj/ui/proc/ReportWindowClosed()
	return
