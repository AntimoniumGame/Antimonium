/obj/item/torch
	name = "torch"
	icon = 'icons/objects/items/torch.dmi'
	sharpness = 0
	weight = 3
	contact_size = 2
	attack_verbs = list("bludgeons", "strikes", "smashes")
	default_material_path = /datum/material/wood
	flags = FLAG_FLAMMABLE | FLAG_SIMULATED
	shadow_size = 1
	light = new(1500, 100, 3)

/obj/item/torch/GetFireIcon()
	return

/obj/item/torch/New(var/newloc, var/material_path, var/_lit)
	..(newloc, material_path)
	if(_lit)
		Ignite()

/obj/item/torch/UpdateIcon(var/list/supplied = list())
	if(IsOnFire())
		icon = 'icons/objects/items/torch_lit.dmi'
		LightOn()
	else
		icon = 'icons/objects/items/torch.dmi'
		LightOff()

	var/mob/holder = loc
	if(istype(holder))
		holder.UpdateInventory()
		holder.UpdateIcon()

/obj/item/torch/Use(var/mob/user)
	if(IsOnFire())
		Extinguish(user)
		user.NotifyNearby("\The [user] extinguishes \the [src].")

/obj/item/torch/Destroy()
	RemoveLight()
	..()
/*
/obj/item/torch/UpdateLight()
	..()
	if(istype(loc, /obj))
		var/obj/O = loc
		O.UpdateLight()
	else if(istype(loc, /mob))
		var/mob/M = loc
		M.UpdateLight(light)
*/
