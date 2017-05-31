/obj/item/stack/ingredient
	name = "ingredient"
	icon = 'icons/objects/items/alchemy/solid_stone_grey.dmi'
	default_material_path = /datum/material/metal/antimonium

	stack_name = "pile"
	singular_name = "portion"
	plural_name = "portions"

/obj/item/ForceMove(var/atom/newloc)
	. = ..()
	if(material)
		if(istype(newloc, /turf) && material_state == STATE_LIQUID)
			new /obj/effect/random/splat(newloc, material.type, src, GetAmount())
			QDel(src)
		else if(!newloc.Airtight() && material_state == STATE_GAS)
			new /obj/effect/gas(get_turf(src), src)
			QDel(src)

/obj/item/stack/ingredient/New(var/newloc, var/material_path, var/_amount, var/obj/donor)
	if(donor)
		if(!material_path)
			material = donor.material
		temperature = donor.temperature
		material_state = donor.material_state
	..(newloc, material_path, _amount)

/obj/item/stack/ingredient/UpdateStrings()
	if(amount == 1)
		name = "[material.GetTerm(material_state, amount)] of [material.GetName(material_state)]"
	else
		name = "[GetAmount()] [material.GetTerm(material_state, amount)] of [material.GetName(material_state)]"

/obj/item/stack/ingredient/UpdateIcon()
	// Gas and liquid states are invisible when held in a container.
	if(material)
		if(material_state == STATE_SOLID)
			icon = material.solid_icon
		else if(material_state == STATE_POWDER)
			icon = material.powder_icon
	else
		if(material_state == STATE_SOLID)
			icon = 'icons/objects/items/alchemy/solid_stone_grey.dmi'
		else if(material_state == STATE_POWDER)
			icon = 'icons/objects/items/alchemy/powder_grey.dmi'
	. = ..()

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

/obj/item/stack/Grind(var/mob/user)
	if(material_state == STATE_SOLID && material && material.grindable)
		if(user)
			user.NotifyNearby("\The [user] grinds \the [src] into a fine powder.")
		material_state = STATE_POWDER
		new /obj/item/stack/ingredient(get_turf(src), material.type, GetAmount(), src)
		QDel(src)
		return TRUE
	return FALSE

/obj/item/stack/ingredient/gold
	name = "gold"
	default_material_path = /datum/material/metal/gold

/obj/item/stack/ingredient/lead
	name = "lead"
	default_material_path = /datum/material/metal/lead

/obj/item/stack/ingredient/iron
	name = "iron"
	default_material_path = /datum/material/metal/iron

/obj/item/stack/ingredient/copper
	name = "copper"
	default_material_path = /datum/material/metal/copper
