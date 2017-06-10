/datum/crafting_recipe/forging
	result_path = /obj/item/weapon/sword
	required_structure = /obj/structure/anvil
	required_skills = SKILL_FORGING
	action_third_person = "forges"

/datum/crafting_recipe/forging/Craft(var/atom/craft_at, var/obj/item/stack/crafting_with)
	. = ..()
	spawn()
		sleep(6)
		PlayLocalSound(craft_at, crafting_with.material.GetConstructionSound(), 100, -1)
		sleep(6)
		PlayLocalSound(craft_at, crafting_with.material.GetConstructionSound(), 100, -1)

/datum/crafting_recipe/forging/axe
	result_path = /obj/item/weapon/axe

/datum/crafting_recipe/forging/dart
	result_path = /obj/item/stack/dart
	result_number = 5

/datum/crafting_recipe/forging/hammer
	result_path = /obj/item/weapon/hammer

/datum/crafting_recipe/forging/mallet
	result_path = /obj/item/weapon/mallet

/datum/crafting_recipe/forging/construction_hammer
	result_path = /obj/item/weapon/construction_hammer

/datum/crafting_recipe/forging/horseshoe
	result_path = /obj/item/horseshoe

/datum/crafting_recipe/forging/handsaw
	result_path = /obj/item/weapon/handsaw

/datum/crafting_recipe/forging/level
	result_path = /obj/item/level

/datum/crafting_recipe/forging/chisel
	result_path = /obj/item/weapon/chisel

/datum/crafting_recipe/forging/pipe
	result_path = /obj/item/weapon/pipe
