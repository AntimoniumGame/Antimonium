/datum/material/cloth
	general_name = "cloth"
	mass = 0.0131
	ignition_point = 700
	crafting_recipe_paths = list(
		/datum/crafting_recipe/tailoring,
		/datum/crafting_recipe/tailoring/gloves,
		/datum/crafting_recipe/tailoring/shirt,
		/datum/crafting_recipe/tailoring/pants
		)
	turf_floor_icon = 'icons/turfs/plain_carpet_floor.dmi'

/datum/material/cloth/felt
	general_name = "felt"

/datum/material/cloth/fur
	general_name = "fur"

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

/datum/material/cloth/silk
	general_name = "silk"
	turf_floor_icon = 'icons/turfs/fancy_carpet_floor.dmi'

/datum/material/cloth/leather
	general_name = "leather"
	mass = 0.86
	thermal_insulation = TEMPERATURE_BURNING + 10 // placeholder

/datum/material/paper
	general_name = "paper"
	mass = 0.012
	ignition_point = 400

/datum/material/wood
	general_name = "wood"
	descriptor = "wooden"
	mass = 0.0038
	ignition_point = 600
	tensile_strength = 30
	hit_sound = 'sounds/effects/thump1.ogg'
	construction_sound = 'sounds/effects/saw1.ogg'
	crafting_recipe_paths = list(
		/datum/crafting_recipe/carpentry,
		/datum/crafting_recipe/carpentry/dartboard,
		)
	turf_floor_icon = 'icons/turfs/wood_floor.dmi'
	turf_wall_icon = 'icons/turfs/wood_wall.dmi'

/datum/material/wood/GetBuildableStructures(var/obj/item/stack/building_with)
	return list(
		/obj/structure/cask,
		/obj/structure/barrel,
		/obj/structure/chair,
		/obj/structure/bench,
		/obj/structure/crate,
		/obj/structure/crate/chest,
		/obj/structure/thread,
		/obj/structure/thread/loom,
		/obj/structure/door,
		/obj/structure/table,
		/obj/structure/table/shelf,
		/obj/structure/table/bench,
		/obj/structure/lectern
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
	ignition_point = 460
	hit_sound = 'sounds/effects/gore1.ogg'
	colour = DARK_RED
	smell_o_vision = TRUE
	tensile_strength = 20

/datum/material/dirt
	general_name = "dirt"
	hit_sound = 'sounds/effects/dig1.ogg'
	tensile_strength = 15
	turf_is_diggable = TRUE
	turf_base_states = 4
	turf_floor_icon = 'icons/turfs/dirt_floor.dmi'
	turf_wall_icon = 'icons/turfs/dirt_wall.dmi'
	demolition_skill = SKILL_DIGGING
	solid_icon = 'icons/objects/items/alchemy/solid_dirt_brown.dmi'
	powder_icon = 'icons/objects/items/alchemy/powder_grey.dmi'     // Stack icon used for ground/powdered pinches.

/datum/material/dirt/grass
	general_name = "grass"
	turf_floor_icon = 'icons/turfs/grass_floor.dmi'

/datum/material/dirt/roots
	general_name = "roots"
	turf_floor_icon = 'icons/turfs/root_floor.dmi'

/datum/material/bone
	general_name = "bone"
	ignition_point = 1275
	colour = WHITE
	powder_name = "bonedust"
	grindable = TRUE
	solid_icon = 'icons/objects/items/bone.dmi'
	tensile_strength = 104

datum/material/ashes
	general_name = "ash"
	colour = BLACK
	powder_name = "ash"
	solid_icon = 'icons/objects/items/alchemy/solid_stone_grey.dmi'
	powder_icon = 'icons/objects/items/alchemy/powder_grey.dmi'