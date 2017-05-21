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
	shadow_size = 3

/obj/item/crucible/AttackedBy(var/mob/user, var/obj/item/prop)
	. = ..()
	if(!.)
		if((prop.flags & FLAG_SIMULATED) && user.DropItem(prop))
			if(prop)
				prop.ForceMove(src)
				user.NotifyNearby("\The [user] places \the [prop] into \the [src].")
				return TRUE

/obj/item/crucible/Use(var/mob/user)
	if(!contents.len)
		return
	for(var/obj/item/thing in contents)
		if(thing.flags & FLAG_SIMULATED)
			user.NotifyNearby("\The [user] empties [thing] out of \the [src].")
			thing.ForceMove(get_turf(src))
			return
	user.Notify("There is nothing inside \the [src].")

/obj/item/crucible/UpdateIcon(var/list/supplied = list())
	..(supplied)
	if(temperature >= TEMPERATURE_FORGE)
		overlays += "glow"
		SetLight()
	else
		KillLight()
