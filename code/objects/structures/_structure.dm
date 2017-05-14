/obj/structure
	name = "structure"
	icon = 'icons/structure/_default.dmi'
	density = 1
	anchored = TRUE
	default_material_path = /data/material
	move_sound = 'sounds/effects/scrape1.wav'

	var/weight = 3
	var/list/holding = list()
	var/hit_sound = 'sounds/effects/thump1.wav'

/obj/structure/update_strings()
	if(material)
		name = "[material.get_descriptor()] [initial(name)]"
	else
		name = initial(name)

/obj/structure/update_values()
	weight *= material.weight_modifier

/obj/structure/pull_cost()
	return weight

/obj/structure/thrown_hit_by(var/atom/movable/projectile)
	if(density)
		projectile.force_move(get_turf(src))
		play_local_sound(src, hit_sound, 20)
		notify_nearby("\The [src] has been hit by \the [projectile]!")
		return TRUE
	return FALSE