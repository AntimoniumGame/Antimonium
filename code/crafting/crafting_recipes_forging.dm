/datum/crafting_recipe/forging
	result_path = /obj/item/weapon/sword
	required_structure = /obj/structure/anvil
	required_skills = SKILL_FORGING
	action_third_person = "forges"

/datum/crafting_recipe/forging/Craft(var/atom/craft_at, var/obj/item/stack/crafting_with)
	. = ..()
	spawn()
		PlayLocalSound(craft_at, 'sounds/effects/ding1.ogg', 100, -1)
		sleep(6)
		PlayLocalSound(craft_at, 'sounds/effects/ding1.ogg', 100, -1)
		sleep(6)
		PlayLocalSound(craft_at, 'sounds/effects/ding1.ogg', 100, -1)

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
