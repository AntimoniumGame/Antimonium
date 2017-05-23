/obj/item/stack/seed
	name = "seed"
	icon = 'icons/objects/items/plants/seed.dmi'
	singular_name = "seed"
	plural_name = "seeds"
	stack_name = "cluster"
	default_material_path = null
	shadow_size = null
	var/plant_type

/obj/item/stack/seed/cotton
	singular_name = "cotton seed"
	plural_name = "cotton seeds"
	plant_type = /obj/item/plant/cotton

/obj/item/stack/seed/nightshade
	singular_name = "nightshade seed"
	plural_name = "nightshade seeds"
	plant_type = /obj/item/plant/nightshade
