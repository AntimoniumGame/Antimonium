/datum/material/cloth
	general_name = "cloth"
	strength = 0.1
	weight_modifier = 0.1
	sharpness_modifier = 0.1
	ignition_point = 700

/datum/material/cloth/cotton
	general_name = "cotton"
	colour = WHITE
	spinnable = TRUE

/datum/material/cloth/wool
	general_name = "wool"
	descriptor = "woolen"
	colour = WHITE
	spinnable = TRUE

/datum/material/cloth/felt
	general_name = "felt"
	descriptor = "felted"

/datum/material/wood
	general_name = "wood"
	descriptor = "wooden"
	strength = 0.3
	weight_modifier = 0.3
	sharpness_modifier = 0.3
	ignition_point = 600
	structural_integrity = 3
	hit_sound = 'sounds/effects/thump1.ogg'
	construction_sound = 'sounds/effects/saw1.ogg'
	crafting_recipe_paths = list(
		/datum/crafting_recipe/carpentry,
		/datum/crafting_recipe/carpentry/dartboard,
		)

/datum/material/wood/GetBuildableStructures(var/obj/item/stack/building_with)
	return list(
		/obj/structure/cask,
		/obj/structure/cask/barrel,
		/obj/structure/chair,
		/obj/structure/bench,
		/obj/structure/crate,
		/obj/structure/crate/chest,
		/obj/structure/spinning_wheel,
		/obj/structure/door,
		/obj/structure/table,
		/obj/structure/table/bench
		)

/datum/material/wood/GetDebris(var/amount)
	return new /obj/item/stack/logs(material_path = type, _amount = amount)

/datum/material/wood/GetBuildableTurfs(var/obj/item/stack/building_with)
	if(building_with.singular_name == "plank")
		return list(/turf/floor/wood)
	return list(/turf/wall/wood)

/datum/material/meat
	general_name = "meat"
	descriptor = "raw"
	strength = 0.3
	weight_modifier = 0.3
	sharpness_modifier = 0.3
	ignition_point = 460
	hit_sound = 'sounds/effects/gore1.ogg'

/datum/material/leather
	general_name = "leather"
	strength = 0.1
	weight_modifier = 0.2
	sharpness_modifier = 0.1
	thermal_insulation = TEMPERATURE_BURNING + 10 // placeholder

/datum/material/dirt
	general_name = "dirt"
	strength = 0.1
	weight_modifier = 0.2
	sharpness_modifier = 0.1
	hit_sound = 'sounds/effects/dig1.ogg'