/obj/structure/crucible
	name = "crucible"
	icon = 'icons/objects/structures/crucible.dmi'
	density = 1
	weight = 1
	default_material_path = /datum/material/stone/clay

	max_contains_count = 10
	max_contains_size_single = 50
	max_contains_size_total =  50
	open = TRUE

/obj/structure/crucible/ToggleOpen(var/mob/user, var/slot)
	return

/obj/structure/crucible/AttackedBy(var/mob/user, var/obj/item/prop)
	if(istype(prop, /obj/item/mold))
		var/obj/item/mold/mold = prop
		if(mold.contains_material)
			user.Notify("\The [prop] is already filled.")
		else
			for(var/obj/item/stack/mat in contains)
				if(mat.material_state == STATE_LIQUID && mat.material && mat.GetAmount() >= mold.material_capacity)
					mold.contains_material = new /obj/item/stack/reagent(mold, mat.material.type, mold.material_capacity, mat)
					mat.Remove(mold.material_capacity)
					NotifyNearby("\The [user] fills \the [prop] from \the [src].", MESSAGE_VISIBLE)
					return TRUE
			user.Notify("There is no usable material within \the [src].")
		return TRUE
	. = ..()
