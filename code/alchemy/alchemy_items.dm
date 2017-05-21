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

/obj/item/stack/ingredient/UpdateStrings()
	if(amount == 1)
		name = "[material.GetTerm(material_state, amount)] of [material.GetName(material_state)]"
	else
		name = "[GetAmount()] [material.GetTerm(material_state, amount)] of [material.GetName(material_state)]"

/obj/item/stack/ingredient/Melt()

	var/mob/holder = loc
	if(istype(holder))
		holder.DropItem(src)

	if(istype(loc, /turf))
		new /obj/effect/random/splat(get_turf(src), material.type, src, amount)
		QDel(src)
	else
		UpdateStrings()
		UpdateIcon()

/obj/item/stack/ingredient/Solidify()
	UpdateStrings()
	UpdateIcon()

/obj/item/stack/ingredient/Evaporate()

	var/mob/holder = loc
	if(istype(holder))
		holder.DropItem(src)

	if(loc.Airtight())
		UpdateStrings()
		UpdateIcon()
	else
		new /obj/effect/gas(get_turf(src), src)
		QDel(src)

/obj/item/stack/ingredient/Condense()
	UpdateStrings()
	UpdateIcon()
