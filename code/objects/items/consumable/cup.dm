/obj/item/vessel/cup
	name = "cup"
	icon = 'icons/objects/items/cup.dmi'
	max_reagent_volume = 10
	default_material_path = /datum/material/wood
	precise_reagent_transfer = FALSE
	held_underlay_states = 1

/obj/item/vessel/bottle
	name = "bottle"
	icon = 'icons/objects/items/bottle_brown.dmi'
	max_reagent_volume = 50
	precise_reagent_transfer = FALSE
	held_underlay_states = 6

/obj/item/vessel/bottle/New()
	..()
	if(prob(50))
		icon = 'icons/objects/items/bottle_clear.dmi'
