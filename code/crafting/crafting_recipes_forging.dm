/datum/crafting_recipe/forging
	result_path = /obj/item/component/sword
	required_structure = /obj/structure/anvil
	required_skills = SKILL_FORGING
	action_third_person = "forges"
	action_third_person_pre = "forging"

/datum/crafting_recipe/forging/Craft(var/atom/craft_at, var/obj/item/stack/crafting_with)
	. = ..()
	if(.)
		spawn()
			sleep(6)
			PlayLocalSound(craft_at, crafting_with.material.GetConstructionSound(), 100, -1)
			sleep(6)
			PlayLocalSound(craft_at, crafting_with.material.GetConstructionSound(), 100, -1)

/datum/crafting_recipe/forging/axe
	result_path = /obj/item/component

/datum/crafting_recipe/forging/hammer
	result_path = /obj/item/component/forge_hammer

/datum/crafting_recipe/forging/mallet
	result_path = /obj/item/component/mallet

/datum/crafting_recipe/forging/construction_hammer
	result_path = /obj/item/component/construction_hammer

/datum/crafting_recipe/forging/sledge_hammer
	result_path = /obj/item/component/sledgehammer

/datum/crafting_recipe/forging/horseshoe
	result_path = /obj/item/horseshoe

/datum/crafting_recipe/forging/handsaw
	result_path = /obj/item/component/handsaw

/datum/crafting_recipe/forging/level
	result_path = /obj/item/level

/datum/crafting_recipe/forging/chisel
	result_path = /obj/item/component/chisel

/datum/crafting_recipe/forging/pipe
	result_path = /obj/item/pipe

/datum/crafting_recipe/forging/shovel
	result_path = /obj/item/component/shovel

/datum/crafting_recipe/forging/pickaxe
	result_path = /obj/item/component/pickaxe

/datum/crafting_recipe/forging/needle
	result_path = /obj/item/needle

