/obj/item/mold
	name = "mold"
	icon = 'icons/objects/items/mold.dmi'
	attack_verbs = list("bludgeons", "strikes", "smashes")
	default_material_path = /datum/material/stone/clay
	flags = FLAG_SIMULATED
	var/obj/item/stack/reagent/contains_material
	var/cast_path
	var/material_capacity = 5

/obj/item/mold/UpdateStrings()
	. = ..()
	if(cast_path)
		var/atom/thing = cast_path
		name = "[name] of \a [initial(thing.name)]"

/obj/item/mold/Destroy()
	if(contains_material)
		QDel(contains_material, "mold qdel'd")
		contains_material = null
	. = ..()

/obj/item/mold/AttackedBy(var/mob/user, var/obj/item/prop)

	if(prop.associated_skill & SKILL_MASONRY)
		if(contains_material)
			user.Notify("<span class='warning'>How do you propose to alter a mold while it is full?</span>")
		else
			// Placeholder.
			cast_path = input("Select an object to shape the mold towards, or cancel to leave it blank.") as null|anything in list(/obj/item/stack/coins)
			UpdateStrings()
		return TRUE

	if(prop.associated_skill & SKILL_FORGING)
		var/found_surface
		for(var/atom/movable/thing in loc)
			if(thing.flags & FLAG_FLAT_SURFACE)
				found_surface = TRUE
				break
		if(found_surface)
			user.NotifyNearby("<span class='notice'>\The [user] cracks \the [src] open with a sharp strike of \the [prop].</span>", MESSAGE_VISIBLE)
			PlayLocalSound(loc, 'sounds/effects/crack1.ogg', 100)
			if(contains_material)
				if(cast_path)
					var/obj/item/casting = new cast_path(loc, material_path = contains_material.material.type)
					if(istype(casting, /obj/item/stack))
						var/obj/item/stack/stack = casting
						stack.SetAmount(material_capacity)
					QDel(contains_material, "material spent")
					contains_material = null
				else
					contains_material.ForceMove(loc)
		else
			user.Notify("<span class='warning'>You must have a flat surface beneath the mold before you can crack it open.</span>")
		return TRUE
	. = ..()
