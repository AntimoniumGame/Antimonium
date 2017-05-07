/obj/ui
	name = ""
	plane = SCREEN_PLANE
	screen_loc = "CENTER,CENTER"
	icon = 'icons/images/ui.dmi'
	var/mob/owner

/obj/ui/destroy()
	owner = null
	. = ..()

/obj/ui/Click()
	if(owner && owner.client)
		owner.notify("You clicked on \the [src] button.")

/obj/ui/New(var/mob/_owner)
	..()
	owner = _owner
	move_to(null)
	verbs.Cut()

/obj/ui/hand
	name = "Left Hand"
	screen_loc = "1,2"

/obj/ui/hand/right
	name = "Right Hand"
	screen_loc = "2,2"
