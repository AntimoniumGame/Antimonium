/obj/item/stack/sticks
	name = "sticks"
	default_material_path = /datum/material/wood
	icon = 'icons/objects/items/sticks.dmi'
	singular_name = "stick"
	plural_name =   "sticks"
	stack_name =    "stack"
	can_craft_with = FALSE

/obj/item/stack/sticks/AttackedBy(var/mob/user, var/obj/item/prop)
	var/obj/item/stack/thread/cloth/cloth = prop
	if(istype(cloth) && material && material.general_name == "wood")
		if(cloth.GetAmount() < 5)
			user.Notify("<span class='warning'>There is not enough cloth in that bundle to make a torch.</span>")
		user.NotifyNearby("<span class='notice'>\The [user] fashions a torch from a stick and some cloth.</span>", MESSAGE_VISIBLE)
		new /obj/item/torch(get_turf(user), material_path = material.type)
		cloth.Remove(5)
		Remove(1)
		return TRUE
	. = ..()
