/turf/wall
	name = "wall"
	icon_state = "map"
	icon = 'icons/turfs/_wall.dmi'
	density = 1
	opacity = 1
	var/integrity = 5
	var/datum/material/material

/turf/wall/New(var/newloc, var/_material_path = /datum/material/stone)
	..(newloc)
	material = GetUniqueDataByPath(_material_path)
	if(material)
		integrity = material.structural_integrity

/turf/wall/AttackedBy(var/mob/user, var/obj/item/prop)
	if(prop.associated_skill & SKILL_MINING)
		NotifyNearby("<span class='danger'>\The [user] strikes \the [src] with \the [prop]!</span>")
		PlayLocalSound(src, material.hit_sound, 100)
		user.SetActionCooldown(6)
		integrity--
		if(material)
			var/atom/movable/debris = material.GetDebris(1)
			if(debris)
				debris.ForceMove(get_turf(user))
		if(integrity <= 0)
			if(material)
				material.ConvertToRuin(src)
			else
				new /turf/floor/dirt(src)
		return TRUE
	. = ..()

/turf/wall/cobble
	name = "dressed stone wall"
	icon = 'icons/turfs/cobble_wall.dmi'

/turf/wall/stone
	name = "stone wall"
	icon = 'icons/turfs/stone_wall.dmi'

/turf/wall/tiled
	name = "tiled wall"
	icon = 'icons/turfs/tile_wall.dmi'

/turf/wall/dirt
	name = "dirt wall"
	icon = 'icons/turfs/dirt_wall.dmi'
	integrity = 1

/turf/wall/dirt/New(var/newloc)
	..(newloc, /datum/material/dirt)

/turf/wall/wood
	name = "wooden wall"
	icon = 'icons/turfs/wood_wall.dmi'

/turf/wall/wood/New(var/newloc)
	..(newloc, /datum/material/wood)

/turf/wall/wood/IsFlammable()
	return TRUE

/turf/wall/wood/IsFlammable()
	return TRUE

/turf/wall/wood/HandleFireDamage()
	if(fire_intensity >= 100)
		KillLight()
		new /turf/floor/dirt(src)

/turf/wall/UpdateIcon(var/list/supplied = list(), var/ignore_neighbors)
	icon_state = ""
	var/list/connected_neighbors = list()
	for(var/thing in Trange(1,src))
		if(thing == src)
			continue
		var/turf/neighbor = thing
		if(!ignore_neighbors)
			neighbor.UpdateIcon(ignore_neighbors = TRUE)
		if(neighbor.density)
			connected_neighbors += get_dir(src, neighbor)

	for(var/i = 1 to 4)
		var/cdir = corner_dirs[i]
		var/corner = 0
		if(cdir in connected_neighbors)
			corner |= 2
		if(turn(cdir,45) in connected_neighbors)
			corner |= 1
		if(turn(cdir,-45) in connected_neighbors)
			corner |= 4
		supplied += image(icon, "[corner]", dir = 1<<(i-1))
	..(supplied)
