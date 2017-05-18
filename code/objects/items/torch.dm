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

/obj/item/torch/attacked_by(var/mob/user, var/obj/item/thing)
	if(istype(thing, /obj/item/torch))
		var/obj/item/torch/torch = thing
		if(!lit && torch.lit)
			user.notify_nearby("\The [user] lights \the [src] from \the [torch].")
			lit = TRUE
			update_light(user)
		else if(lit && !torch.lit)
			user.notify_nearby("\The [user] lights \the [torch] with \the [src].")
			torch.lit = TRUE
			torch.update_light(user)

/obj/item/torch/New(var/newloc, var/material_path, var/_lit)
	lit = _lit
	update_light()
	..(newloc, material_path)

/obj/item/torch/update_icon()
	if(lit)
		icon = 'icons/objects/items/torch_lit.dmi'
	else
		icon = 'icons/objects/items/torch.dmi'

/obj/item/torch/use(var/mob/user)
	if(lit)
		lit = !lit
		update_light(user)
		user.notify_nearby("\The [user] extinguishes \the [src].")

/obj/item/torch/proc/update_light(var/mob/user)
	update_icon()
	if(lit)
		set_light()
	else
		kill_light()
	if(user)
		user.update_inventory()
		user.update_icon()
