/obj/item/stack/ingredient/attacked_by(var/mob/user, var/obj/item/prop)
	if(!try_craft(user, prop))
		return ..()
	return TRUE

/obj/item/stack/ingredient/proc/try_craft(var/mob/user, var/obj/item/prop)
	if(!material || !prop.associated_skill)
		return FALSE

	var/list/valid_recipes = material.get_recipes_for(prop.associated_skill, get_turf(src), src)

	if(!valid_recipes || !valid_recipes.len)
		return FALSE

	var/datum/crafting_recipe/crecipe = input("What do you wish to craft?") as null|anything in valid_recipes
	if(!crecipe || !src || deleted(src) || !crecipe.can_craft(get_turf(src), src) || !user || !is_adjacent_to(user, src))
		return FALSE

	var/obj/item/result = crecipe.craft(get_turf(src), src)
	user.do_attack_animation(get_turf(src), prop)
	user.notify_nearby("\The [user] [crecipe.action_third_person] \a [crecipe.result_name] out of [result.material.get_name()].")
	return TRUE
