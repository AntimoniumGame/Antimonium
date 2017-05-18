/obj/item/stack/dart
	name = "dart"
	icon = 'icons/objects/items/dart.dmi'
	attack_verbs = list("sticks")
	hit_sound = 'sounds/effects/thunk1.ogg'

	singular_name = "dart"
	plural_name =   "darts"
	weight = 1
	sharpness = 1
	contact_size = 1
	default_material_path = /datum/material/iron
	amount = 5
	max_amount = 5
	flags = FLAG_SIMULATED

/obj/item/stack/dart/New()
	..()
	pixel_x = rand(-3,3)
	pixel_y = rand(-3,3)
