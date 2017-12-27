/datum/crafting_recipe/tailoring
	result_path = /obj/item/clothing/boots
	required_structure = /obj/structure/table/bench
	required_skills = SKILL_TAILORING
	action_third_person = "tailors"
	action_third_person_pre = "tailoring"

/datum/crafting_recipe/tailoring/Craft(var/atom/craft_at, var/obj/item/stack/crafting_with)
	var/dyed = WHITE
	if(istype(crafting_with, /obj/item/stack/thread))
		var/obj/item/stack/thread/source = crafting_with
		dyed = source.dyed
	. = ..()
	if(istype(., /obj/item/clothing))
		var/obj/item/clothing/clothes = .
		clothes.SetDyed(dyed)

/datum/crafting_recipe/tailoring/pants
	result_path = /obj/item/clothing/pants

/datum/crafting_recipe/tailoring/shirt
	result_path = /obj/item/clothing/shirt

/datum/crafting_recipe/tailoring/gloves
	result_path = /obj/item/clothing/gloves
