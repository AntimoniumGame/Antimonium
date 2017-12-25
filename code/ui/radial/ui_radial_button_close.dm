/obj/ui/radial_button/close
	name = "Close"
	icon = 'icons/images/ui_radial_close.dmi'

/obj/ui/radial_button/close/New(var/mob/_owner, var/obj/ui/radial_menu/_parent_menu)
	..(_owner, _parent_menu)
	layer++

/obj/ui/radial_button/close/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	. = ..()
	if(.)
		QDel(parent_menu, "closed")

/obj/ui/radial_button/close/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	. = ..()
	if(.)
		QDel(parent_menu, "closed")