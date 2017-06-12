/obj/ui/radial_button
	screen_loc = "CENTER,CENTER"
	var/obj/ui/radial_menu/parent_menu

/obj/ui/radial_button/Destroy()
	parent_menu = null
	. = ..()

/obj/ui/radial_button/proc/GetAtom()
	return src

/obj/ui/radial_button/New(var/mob/_owner, var/obj/ui/radial_menu/_parent_menu)
	..(_owner)
	parent_menu = _parent_menu
	UpdateAppearance()

/obj/ui/radial_button/proc/UpdateAppearance()
	plane = parent_menu.plane
	layer = parent_menu.layer + 1
	UpdateShadowUnderlay()