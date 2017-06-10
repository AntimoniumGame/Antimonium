/obj/item/stack/sticks
	name = "sticks"
	contact_size = 1
	weight = 1
	default_material_path = /datum/material/wood
	icon = 'icons/objects/items/sticks.dmi'
	singular_name = "stick"
	plural_name =   "sticks"
	stack_name =    "stack"
	can_craft_with = FALSE

/obj/item/stack/sticks/AttackedBy(var/mob/user, var/obj/item/prop)
	var/obj/item/stack/thread/thread = prop // Swap for cloth when it exists.
	if(istype(thread) && material && material.general_name == "wood")
		if(thread.GetAmount() < 5)
			user.Notify("<span class='warning'>There is not enough cloth in that bundle to make a torch.</span>")
		user.NotifyNearby("<span class='notice'>\The [user] fashions a torch from a stick and some cloth.</span>")
		new /obj/item/torch(get_turf(user), material_path = material.type)
		thread.Remove(5)
		Remove(1)
		return TRUE
	. = ..()
