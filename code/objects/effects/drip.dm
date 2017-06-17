/obj/effect/random/drip
	name = "drip"
	icon = 'icons/objects/effects/rain.dmi'
	random_states = 1
	random_state_prefix = ""

	var/amount = 1
	var/list/splat_images = list()

/obj/effect/random/drip/GetWeight()
	return max(1,amount)

/obj/effect/random/drip/New()
	spawn(rand(1,10))

	..()