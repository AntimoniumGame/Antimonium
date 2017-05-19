/obj
	icon = 'icons/objects/object.dmi'
	layer = ITEM_LAYER

	var/material_state = STATE_SOLID
	var/datum/material/material
	var/default_material_path

/obj/New(var/newloc, var/material_path)
	if(!material)
		if(!ispath(material_path) && ispath(default_material_path))
			material_path = default_material_path
		if(ispath(material_path))
			material = get_unique_data_by_path(material_path)
	if(material && material.is_temperature_sensitive())
		flags |= FLAG_TEMPERATURE_SENSITIVE

		if(temperature >= material.boiling_point)
			material_state = STATE_GAS
		else if(temperature >= material.melting_point)
			material_state = STATE_LIQUID
		else
			material_state = STATE_SOLID

	update_values()
	..(newloc)

/obj/proc/update_values()
	return

/obj/proc/process()
	return

/obj/is_flammable()
	if(!material)
		return ..()
	else
		return (material.is_flammable())// && temperature >= material.ignition_point)

/obj/is_solid()
	return (material_state == STATE_SOLID || material_state == STATE_POWDER)
