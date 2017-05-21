/datum/material
	var/list/crafting_recipe_paths = list()
	var/list/recipes = list()

/datum/material/New()
	..()
	for(var/recipe in crafting_recipe_paths)
		recipes += GetUniqueDataByPath(recipe)

/datum/material/proc/GetRecipesFor(var/skills, var/atom/craft_at, var/obj/item/stack/crafting_with)
	if(!skills || !craft_at || !crafting_with)
		return list()
	var/list/valid_recipes = list()
	for(var/datum/crafting_recipe/crecipe in recipes)
		if((skills & crecipe.required_skills) && crecipe.CanCraft(craft_at, crafting_with))
			valid_recipes += crecipe
	return valid_recipes
