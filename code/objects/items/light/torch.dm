/obj/item/torch
	name = "torch"
	icon = 'icons/objects/items/torch.dmi'
	attack_verbs = list("bludgeons", "strikes", "smashes")
	default_material_path = /datum/material/wood
	flags = FLAG_FLAMMABLE | FLAG_SIMULATED

/obj/item/torch/GetFireIconState()
	return

/obj/item/torch/New(var/newloc, var/material_path, var/_lit)
	..(newloc, material_path)
	if(_lit)
		Ignite()

/obj/item/torch/Extinguish()
	. = ..()
	UpdateIcon()

/obj/item/torch/Ignite()
	. = ..()
	UpdateIcon()

/obj/item/torch/UpdateIcon()
	if(IsOnFire())
		icon = 'icons/objects/items/torch_lit.dmi'
	else
		icon = 'icons/objects/items/torch.dmi'
	..()

/obj/item/torch/Use(var/mob/user)
	. = ..()
	if(!. && IsOnFire())
		Extinguish(user)
		user.NotifyNearby("<span class='notice'>\The [user] extinguishes \the [src].</span>", MESSAGE_VISIBLE)

/obj/item/torch/Destroy()
	var/obj/structure/sconce/sconce = loc
	if(istype(sconce) && sconce.filled == src)
		sconce.filled = null
		sconce.UpdateIcon()
	. = ..()
