/obj/effect
	name = ""
	mouse_opacity = 0
	density = 0
	layer = TURF_LAYER+0.1
	icon = 'icons/objects/effects/effect.dmi'
	flags = FLAG_ETHEREAL | FLAG_ANCHORED

/obj/effect/New()
	..()
	verbs.Cut()
