/obj/item/horseshoe
	name = "horseshoe"
	icon = 'icons/objects/items/horseshoe.dmi'
	sharpness = 0
	weight = 5
	contact_size = 3
	default_material_path = /datum/material/iron
	attack_verbs = list("punches") // Like impromptu brass knuckles?

/obj/item/horseshoe/New()
	..()
	pixel_x = rand(-3,3)
	pixel_y = rand(-3,3)
