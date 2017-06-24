/datum/crafting_recipe/masonry
	result_path = /obj/item/stack/bricks
	required_structure = /obj/structure/table/bench
	required_skills = SKILL_MASONRY
	action_third_person = "carves"
	action_third_person_pre = "carving"
	result_number = 5

/datum/crafting_recipe/masonry/Craft(var/atom/craft_at, var/obj/item/stack/crafting_with)
	. = ..()
	if(.)
		spawn()
			sleep(3)
			PlayLocalSound(craft_at, crafting_with.material.GetConstructionSound(), 75, -1)
			sleep(3)
			PlayLocalSound(craft_at, crafting_with.material.GetConstructionSound(), 75, -1)

/datum/crafting_recipe/masonry/tiles
	result_path = /obj/item/stack/tiles
