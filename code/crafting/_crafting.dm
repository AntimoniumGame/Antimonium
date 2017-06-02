/datum/crafting_recipe
	var/result_name
	var/result_path = /obj/item
	var/result_number = 1 // Only relevant to stacks.
	var/material_cost
	var/required_structure
	var/required_skills = 0
	var/action_third_person = "crafts"

/datum/crafting_recipe/New()
	..()
	var/obj/item/thing = result_path
	result_name = initial(thing.name)
	if(isnull(material_cost))
		material_cost = round((initial(thing.weight) * result_number) * 1.5)

/datum/crafting_recipe/proc/CanCraft(var/atom/craft_at, var/obj/item/stack/crafting_with)
	return (!required_structure || (istype(craft_at, required_structure) || \
	 (locate(required_structure) in craft_at)) && \
	 crafting_with.GetAmount() >= material_cost)

/datum/crafting_recipe/proc/Craft(var/atom/craft_at, var/obj/item/stack/crafting_with)
	var/obj/item/thing = new result_path(craft_at, crafting_with.material.type)
	if(istype(thing, /obj/item/stack))
		var/obj/item/stack/thing_stack = thing
		thing_stack.SetAmt(result_number)
	crafting_with.Remove(material_cost)
	return thing
