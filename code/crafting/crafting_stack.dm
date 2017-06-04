/obj/item/stack/proc/TryCraft(var/mob/user, var/obj/item/prop)
	if(!material || !prop.associated_skill)
		return FALSE

	var/list/valid_recipes = material.GetRecipesFor(prop.associated_skill, get_turf(src), src)

	if(!valid_recipes || !valid_recipes.len)
		return FALSE

	var/datum/crafting_recipe/crecipe = input("What do you wish to craft?") as null|anything in valid_recipes
	if(!crecipe || !src || Deleted(src) || !crecipe.CanCraft(get_turf(src), src) || !user || !IsAdjacentTo(user, src))
		return FALSE

	var/obj/item/result = crecipe.Craft(get_turf(src), src)
	user.DoAttackAnimation(get_turf(src), prop)
	user.NotifyNearby("<span class='notice'>\The [user] [crecipe.action_third_person] \a [crecipe.result_name] out of [result.material.GetName()].</span>")
	return TRUE
