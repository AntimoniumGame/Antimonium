/obj/effect/title
	name = "Antimonium"
	icon = 'icons/images/title_image.dmi'
	screen_loc = "CENTER, CENTER"
	plane = SCREEN_PLANE
	layer = 3
	var/mob/holder

/obj/effect/title/proc/Center(var/view_x, var/view_y)
	screen_loc = "[round(view_x/2)-7]:16,[round(view_y/2)-6]"

/obj/effect/title/New(var/mob/_holder)
	..()
	holder = _holder
	holder.ui_screen += src
	NullLoc(src)

/obj/effect/title/Destroy()
	..()
	if(holder)
		holder.ui_screen -= src
	. = ..()
