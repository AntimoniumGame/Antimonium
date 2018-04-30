/obj/item/stack/logs
	name = "logs"
	default_material_path = /datum/material/wood
	icon = 'icons/objects/items/logs.dmi'
	singular_name = "log"
	plural_name =   "logs"
	stack_name =    "stack"
	can_craft_with = FALSE

/obj/item/stack/logs/AttackedBy(var/mob/user, var/obj/item/prop)
	if(prop.associated_skill & SKILL_CARPENTRY)
		Remove(1)
		PlayLocalSound(user, material.GetConstructionSound(), 75)
		new /obj/item/stack/planks(get_turf(user), material_path = material.type, _amount = 3)
		user.NotifyNearby("<span class='notice'>\The [user] saws a log into some planks.</span>", MESSAGE_VISIBLE)
		return TRUE
	. = ..()
