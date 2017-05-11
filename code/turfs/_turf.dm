/turf
	name = "floor"
	icon = 'icons/turfs/turf.dmi'
	layer = TURF_LAYER
	luminosity = 1

/turf/wall
	name = "wall"
	density = 1
	opacity = 1
	icon_state = "wall"

/turf/left_clicked_on(var/mob/clicker)
	if(clicker.intent.selecting == INTENT_HARM && contents.len)
		var/atom/thing = pick(contents)
		thing.left_clicked_on(clicker)
		return

/turf/right_clicked_on(var/mob/clicker)
	if(clicker.intent.selecting == INTENT_HARM && contents.len)
		var/atom/thing = pick(contents)
		thing.right_clicked_on(clicker)
		return
