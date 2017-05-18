/obj/effect/title
	name = "Antimonium"
	icon = 'icons/images/title_image.dmi'
	screen_loc = "CENTER, CENTER"
	plane = SCREEN_PLANE
	layer = 3
	var/mob/holder

/obj/effect/title/proc/center(var/view_x, var/view_y)
	screen_loc = "[round(view_x/2)-7]:16,[round(view_y/2)-6]"

/obj/effect/title/New(var/mob/_holder)
	..()
	holder = _holder
	holder.ui_screen += src
	null_loc(src)

/obj/effect/title/destroy()
	..()
	if(holder)
		holder.ui_screen -= src
	. = ..()
