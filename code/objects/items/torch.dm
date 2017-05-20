/obj/item/torch
	name = "torch"
	icon = 'icons/objects/items/torch.dmi'
	sharpness = 0
	weight = 3
	contact_size = 2
	attack_verbs = list("bludgeons", "strikes", "smashes")
	default_material_path = /datum/material/wood
	flags = FLAG_FLAMMABLE | FLAG_SIMULATED

/obj/item/torch/get_fire_icon()
	return

/obj/item/torch/New(var/newloc, var/material_path, var/_lit)
	..(newloc, material_path)
	if(_lit)
		ignite()

/obj/item/torch/update_icon(var/list/supplied = list())
	if(is_on_fire())
		icon = 'icons/objects/items/torch_lit.dmi'
	else
		icon = 'icons/objects/items/torch.dmi'

	var/mob/holder = loc
	if(istype(holder))
		holder.update_inventory()
		holder.update_icon()

/obj/item/torch/use(var/mob/user)
	if(is_on_fire())
		extinguish(user)
		user.notify_nearby("\The [user] extinguishes \the [src].")
