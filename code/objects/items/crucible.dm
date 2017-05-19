/obj/item/crucible
	name = "crucible"
	icon = 'icons/objects/items/crucible.dmi'
	density = 1
	sharpness = 0
	weight = 20
	contact_size = 5
	default_material_path = /datum/material/stone/clay
	attack_verbs = list("bludgeons")
	light_color = BRIGHT_ORANGE
	light_power = 5
	light_range = 3

/obj/item/crucible/attacked_by(var/mob/user, var/obj/item/prop)
	if((prop.flags & FLAG_SIMULATED) && user.drop_item(prop))
		if(prop)
			prop.force_move(src)
			user.notify_nearby("\The [user] places \the [prop] into \the [src].")
			return TRUE
	return ..()

/obj/item/crucible/use(var/mob/user)
	if(!contents.len)
		return
	for(var/obj/item/thing in contents)
		if(thing.flags & FLAG_SIMULATED)
			thing.force_move(get_turf(src))
			user.notify_nearby("\The [user] empties [thing] out of \the [src].")
			return
	user.notify("There is nothing inside \the [src].")

/obj/item/crucible/update_icon()
	overlays.Cut()
	if(temperature >= TEMPERATURE_FORGE)
		overlays += "glow"
		set_light()
	else
		kill_light()
