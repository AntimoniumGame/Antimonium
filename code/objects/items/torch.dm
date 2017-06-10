/obj/item/torch
	name = "torch"
	icon = 'icons/objects/items/torch.dmi'
	sharpness = 0
	weight = 3
	contact_size = 2
	attack_verbs = list("bludgeons", "strikes", "smashes")
	default_material_path = /datum/material/wood
	flags = FLAG_FLAMMABLE | FLAG_SIMULATED
	light = new(1500, 100, 3)
	var/fuel = 100

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
		user.NotifyNearby("<span class='notice'>\The [user] extinguishes \the [src].</span>")

/obj/item/torch/Destroy()
	var/obj/structure/sconce/sconce = loc
	if(istype(sconce) && sconce.filled == src)
		sconce.filled = null
		sconce.UpdateIcon()
	RemoveLight()
	..()

/obj/item/torch/HandleFireDamage()
	/*
	fuel--
	if(!fuel)
		QDel(src)
	*/
