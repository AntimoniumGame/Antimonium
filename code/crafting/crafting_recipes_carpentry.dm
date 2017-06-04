/datum/crafting_recipe/carpentry
	result_path = /obj/item/stack/sticks
	required_structure = /obj/structure/table/bench
	required_skills = SKILL_CARPENTRY
	action_third_person = "cuts"
	result_number = 3

/datum/crafting_recipe/carpentry/Craft(var/atom/craft_at, var/obj/item/stack/crafting_with)
	. = ..()
	spawn()
		PlayLocalSound(craft_at, 'sounds/effects/saw1.ogg', 100, -1)

/datum/crafting_recipe/carpentry/dartboard
	result_path = /obj/item/dartboard
	result_number = 1
