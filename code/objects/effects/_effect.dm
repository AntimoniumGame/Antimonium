/obj/effect
	name = ""
	mouse_opacity = 0
	density = 0
	layer = TURF_LAYER+0.1
	anchored = TRUE
	ethereal = TRUE
	simulated = FALSE
	icon = 'icons/objects/effects/effect.dmi'

/obj/effect/New()
	..()
	verbs.Cut()
