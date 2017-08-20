/obj
	icon = 'icons/objects/object.dmi'
	layer = ITEM_LAYER

	var/worth = 1
	var/material_state = STATE_SOLID
	var/datum/material/material
	var/default_material_path

/obj/New(var/newloc, var/material_path)

	if(!material)
		if(!ispath(material_path) && ispath(default_material_path))
			material_path = default_material_path
		if(ispath(material_path))
			material = GetUniqueDataByPath(material_path)

	if(material && material.IsTemperatureSensitive())
		flags |= FLAG_TEMPERATURE_SENSITIVE

		if(temperature >= material.boiling_point)
			material_state = STATE_GAS
		else if(temperature >= material.melting_point)
			material_state = STATE_LIQUID
		else if(material_state != STATE_POWDER)
			material_state = STATE_SOLID

	UpdateValues()
	..(newloc)

/obj/proc/UpdateValues()
	return

/obj/proc/Process()
	return

/obj/UpdateIcon()
	UpdateShadowUnderlay()
	UpdateFireOverlay()
	..()

/obj/IsFlammable()
	if(!material)
		return ..()
	else
		return (material.IsFlammable())// && temperature >= material.ignition_point)

/obj/IsSolid()
	return (material_state == STATE_SOLID || material_state == STATE_POWDER)

/obj/proc/GetBaseMonetaryWorth()
	return worth

/obj/proc/GetMonetaryWorth()
	var/amt = GetBaseMonetaryWorth()
	var/mod_amt = amt
	if(material)
		amt += mod_amt * material.value_modifier
	return amt
