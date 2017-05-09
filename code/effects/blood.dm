/obj/effect/random/blood
	name = "blood"
	icon = 'icons/objects/effects/blood.dmi'
	random_states = 3
	random_state_prefix = "small"
	var/list/blood_images = list()

/obj/effect/random/blood/New()
	for(var/obj/effect/random/blood/blood in get_turf(loc))
		if(blood == src)
			continue
		if(!transform && blood.transform)
			transform = blood.transform
		blood_images |= blood.icon_state
		blood_images |= blood.blood_images
		qdel(blood)

	overlays = blood_images
	if(blood_images.len >= 3)
		random_state_prefix = null
		icon_state = "[rand(1,random_states)]"
	..()
