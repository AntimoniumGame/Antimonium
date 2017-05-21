/obj/item/torch
	name = "torch"
	icon = 'icons/objects/items/torch.dmi'
	sharpness = 0
	weight = 3
	contact_size = 2
	attack_verbs = list("bludgeons", "strikes", "smashes")
	default_material_path = /datum/material/wood
	flags = FLAG_FLAMMABLE | FLAG_SIMULATED

/obj/item/torch/GetFireIcon()
	return

/obj/item/torch/New(var/newloc, var/material_path, var/_lit)
	..(newloc, material_path)
	if(_lit)
		Ignite()

/obj/item/torch/UpdateIcon(var/list/supplied = list())
	if(IsOnFire())
		icon = 'icons/objects/items/torch_lit.dmi'
	else
		icon = 'icons/objects/items/torch.dmi'

	var/mob/holder = loc
	if(istype(holder))
		holder.UpdateInventory()
		holder.UpdateIcon()

/obj/item/torch/Use(var/mob/user)
	if(IsOnFire())
		Extinguish(user)
		user.NotifyNearby("\The [user] extinguishes \the [src].")
