/obj/item/torch
	name = "torch"
	icon = 'icons/objects/items/torch.dmi'
	light_color = BRIGHT_ORANGE
	light_power = 8
	light_range = 4
	sharpness = 0
	weight = 3
	contact_size = 2
	attack_verbs = list("bludgeons", "strikes", "smashes")
	default_material_path = /datum/material/wood

/obj/item/torch/New(var/newloc, var/material_path, var/_lit)
	..(newloc, material_path)
	if(_lit)
		ignite()

/obj/item/torch/ignite(var/mob/user)
	..()
	update_light(user)

/obj/item/torch/extinguish(var/mob/user)
	..()
	update_light(user)

/obj/item/torch/update_icon()
	if(on_fire)
		icon = 'icons/objects/items/torch_lit.dmi'
	else
		icon = 'icons/objects/items/torch.dmi'

/obj/item/torch/use(var/mob/user)
	if(on_fire)
		extinguish(user)
		user.notify_nearby("\The [user] extinguishes \the [src].")

/obj/item/torch/proc/update_light(var/mob/user)
	update_icon()
	if(on_fire)
		set_light()
	else
		kill_light()
	if(user)
		user.update_inventory()
		user.update_icon()
