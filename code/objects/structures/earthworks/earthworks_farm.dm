/obj/structure/earthworks/farm
	name = "tilled soil"
	icon = 'icons/objects/structures/farm.dmi'
	gender = PLURAL
	var/list/occupied_spots = list()

/obj/structure/earthworks/farm/Initialize()
	..()
	dir = pick(cardinal_dirs)

/obj/structure/earthworks/farm/AttackedBy(var/mob/user, var/obj/item/prop)
	if(istype(prop, /obj/item/stack/seed))
		var/obj/item/stack/seed/seed = prop
		for(var/plot_x = 1 to 4)
			for(var/plot_y = 1 to 4)
				var/plot_key = "[plot_x]-[plot_y]"
				if(occupied_spots[plot_key])
					continue
				var/obj/item/plant/newplant = new seed.plant_type(loc, src)
				newplant.pixel_x += (plot_x * 8)-20
				newplant.pixel_y += (plot_y * 8)-20
				occupied_spots[plot_key] = newplant
				seed.Remove(1)
				user.NotifyNearby("\The [user] plants \a [newplant] in \the [src].")
				return TRUE
		user.Notify("There is no more room in this plot.")
		return TRUE
	. = ..()

/obj/structure/earthworks/farm/FillIn(var/mob/user)
	for(var/obj/item/plant/plant in loc)
		if(plant.growing_in == src)
			user.Notify("You must clear out the crops before destroying the tilled soil.")
			return FALSE
	. = ..()
