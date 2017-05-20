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
	var/lit = FALSE

/obj/item/torch/AttackedBy(var/mob/user, var/obj/item/thing)
	if(istype(thing, /obj/item/torch))
		var/obj/item/torch/torch = thing
		if(!lit && torch.lit)
			user.NotifyNearby("\The [user] lights \the [src] from \the [torch].")
			lit = TRUE
			UpdateLight(user)
		else if(lit && !torch.lit)
			user.NotifyNearby("\The [user] lights \the [torch] with \the [src].")
			torch.lit = TRUE
			torch.UpdateLight(user)

/obj/item/torch/New(var/newloc, var/material_path, var/_lit)
	lit = _lit
	UpdateLight()
	..(newloc, material_path)

/obj/item/torch/UpdateIcon()
	if(lit)
		icon = 'icons/objects/items/torch_lit.dmi'
	else
		icon = 'icons/objects/items/torch.dmi'

/obj/item/torch/Use(var/mob/user)
	if(lit)
		lit = !lit
		UpdateLight(user)
		user.NotifyNearby("\The [user] extinguishes \the [src].")

/obj/item/torch/proc/UpdateLight(var/mob/user)
	UpdateIcon()
	if(lit)
		SetLight()
	else
		KillLight()
	if(user)
		user.UpdateInventory()
		user.UpdateIcon()
