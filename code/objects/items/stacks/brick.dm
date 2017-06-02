/obj/item/stack/bricks
	name = "bricks"
	contact_size = 5
	default_material_path = /datum/material/stone
	icon = 'icons/objects/items/stone_brick.dmi'
	singular_name = "brick"
	plural_name =   "bricks"
	stack_name =    "stack"
	icon_state = "1"
	crafted = FALSE

/obj/item/stack/bricks/New()
	..()
	icon_state = GetIndividualStackIcon()

/obj/item/stack/bricks/GetIndividualStackIcon()
	return "[rand(1,3)]"
