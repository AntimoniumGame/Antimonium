/datum/material/stone
	general_name = "stone"
	melting_point = 1600
	boiling_point = TEMPERATURE_NEVER_HOT
	colour = PALE_GREY
	weight_modifier = 1
	sharpness_modifier = 1.5
	structural_integrity = 60
	crafting_recipe_paths = list(
		/datum/crafting_recipe/masonry,
		/datum/crafting_recipe/masonry/tiles
		)
	construction_sound = 'sounds/effects/chisel1.ogg'
	turf_floor_icon = 'icons/turfs/stone_floor.dmi'
	turf_wall_icon = 'icons/turfs/stone_wall.dmi'

/datum/material/stone/brick
	general_name = "flagstone"
	turf_floor_icon = 'icons/turfs/brick_floor.dmi'
	turf_wall_icon = 'icons/turfs/cobble_wall.dmi' //todo

/datum/material/stone/cobble
	general_name = "cobblestone"
	turf_floor_icon = 'icons/turfs/cobble_floor.dmi'
	turf_wall_icon = 'icons/turfs/cobble_wall.dmi'

/datum/material/stone/tiles
	general_name = "tile"
	descriptor = "tiled"
	turf_floor_icon = 'icons/turfs/tile_floor.dmi'
	turf_wall_icon = 'icons/turfs/tile_wall.dmi'

/datum/material/stone/GetBuildableStructures(var/obj/item/stack/building_with)
	return list(/obj/structure/stairs)

/datum/material/stone/ConvertToRuin(var/loc)
	new /turf/floor/stone(loc)

/datum/material/stone/GetBuildableTurfs(var/obj/item/stack/building_with)
	if(building_with.singular_name == "brick")
		return list(/turf/floor/flagstones)
	else if(building_with.singular_name == "tile")
		return list(/turf/wall/tiled, /turf/floor/tiled)
	else
		return list(/turf/wall/cobble, /turf/floor/cobble)

/datum/material/stone/glass
	general_name = "glass"
	melting_point = 1400
	sharpness_modifier = 5
	crafting_recipe_paths = list()
	turf_wall_is_transparent = 1

/datum/material/stone/glass/sand
	general_name = "sand"
	turf_floor_icon = 'icons/turfs/sand_floor.dmi'

/datum/material/stone/glass/GetBuildableStructures(var/obj/item/stack/building_with)
	return list(/obj/structure/alembic)

/datum/material/stone/glass/GetBuildableTurfs(var/obj/item/stack/building_with)
	return list()

/datum/material/stone/clay
	general_name = "fired clay"
	descriptor = "ceramic"
	colour = DARK_RED
	melting_point = 2200
	weight_modifier = 2
	crafting_recipe_paths = list()

/datum/material/stone/clay/GetBuildableTurfs(var/obj/item/stack/building_with)
	return list()
