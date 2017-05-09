/mob/human
	name = "human"
	density = 1
	var/prone = FALSE

/mob/human/New()
	..()
	create_limbs()
	update_icon()

/mob/human/verb/lie_down()
	set name = "Lie Down"
	set category = "Debug"

	prone = !prone
	density = !prone
	notify_nearby("\The [src] [prone ? "lies down" : "stands up"].")
	update_icon()