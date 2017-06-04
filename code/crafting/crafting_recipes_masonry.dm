/datum/crafting_recipe/masonry
	result_path = /obj/item/stack/bricks
	required_structure = /obj/structure/table/bench
	required_skills = SKILL_MASONRY
	action_third_person = "carves"
	result_number = 5

/datum/crafting_recipe/masonry/Craft(var/atom/craft_at, var/obj/item/stack/crafting_with)
	. = ..()
	spawn()
		PlayLocalSound(craft_at, 'sounds/effects/chisel1.ogg', 100, -1)
		sleep(3)
		PlayLocalSound(craft_at, 'sounds/effects/chisel1.ogg', 100, -1)
		sleep(3)
		PlayLocalSound(craft_at, 'sounds/effects/chisel1.ogg', 100, -1)

/datum/crafting_recipe/masonry/tiles
	result_path = /obj/item/stack/tiles
