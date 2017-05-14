/obj/item/weapon/dart
	name = "dart"
	weight = 1
	sharpness = 1
	contact_size = 1
	icon = 'icons/objects/items/dart.dmi'
	attack_verbs = list("sticks")
	hit_sound = 'sounds/effects/thunk1.ogg'
	interaction_flags = FLAG_SIMULATED

/obj/item/weapon/dart/New()
	..()
	pixel_x = rand(-3,3)
	pixel_y = rand(-3,3)
