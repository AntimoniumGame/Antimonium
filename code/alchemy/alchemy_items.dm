/obj/item/stack/ingredient
	name = "ingredient"
	icon = 'icons/objects/items/alchemy/solid.dmi'
	default_material_path = /datum/material/metal/antimonium

	stack_name = "pile"
	singular_name = "portion"
	plural_name = "portions"

/obj/item/force_move(var/atom/newloc)
	. = ..()
	if(material)
		if(istype(newloc, /turf) && material_state == STATE_LIQUID)
			new /obj/effect/random/splat(newloc, material.type, src, get_amount())
			qdel(src)
		else if(!newloc.airtight() && material_state == STATE_GAS)
			new /obj/effect/gas(get_turf(src), src)
			qdel(src)

/obj/item/stack/ingredient/New(var/newloc, var/material_path, var/_amount, var/obj/donor)
	if(donor)
		if(!material_path)
			material = donor.material
		temperature = donor.temperature
	..(newloc, material_path, _amount)

/obj/item/stack/ingredient/update_strings()
	if(amount == 1)
		name = "[material.get_term(material_state, amount)] of [material.get_name(material_state)]"
	else
		name = "[get_amount()] [material.get_term(material_state, amount)] of [material.get_name(material_state)]"

/obj/item/stack/ingredient/melt()

	var/mob/holder = loc
	if(istype(holder))
		holder.drop_item(src)

	if(istype(loc, /turf))
		new /obj/effect/random/splat(get_turf(src), material.type, src, amount)
		qdel(src)
	else
		update_strings()
		update_icon()

/obj/item/stack/ingredient/solidify()
	update_strings()
	update_icon()

/obj/item/stack/ingredient/evaporate()

	var/mob/holder = loc
	if(istype(holder))
		holder.drop_item(src)

	if(loc.airtight())
		update_strings()
		update_icon()
	else
		new /obj/effect/gas(get_turf(src), src)
		qdel(src)

/obj/item/stack/ingredient/condense()
	update_strings()
	update_icon()
