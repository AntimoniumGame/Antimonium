/datum/material/stone
	general_name = "stone"
	melting_point = 1600
	boiling_point = TEMPERATURE_NEVER_HOT
	colour = PALE_GREY
	weight_modifier = 1
	sharpness_modifier = 1.5
	crafting_recipe_paths = list(
		/datum/crafting_recipe/masonry,
		/datum/crafting_recipe/masonry/tiles
		)

/datum/material/stone/GetBuildableTurfs(var/obj/item/stack/building_with)
	if(building_with.singular_name == "brick")
		return list() // todo
	else if(building_with.singular_name == "tile")
		return list(/turf/wall/tiled, /turf/floor/tiled)
	else
		return list(/turf/wall/cobble, /turf/floor/cobble)

/datum/material/stone/glass
	general_name = "glass"
	melting_point = 1400
	sharpness_modifier = 5
	crafting_recipe_paths = list()

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
