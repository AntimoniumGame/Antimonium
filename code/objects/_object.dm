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
			material = GetUniqueDataByPath(material_path)
	if(material && material.IsTemperatureSensitive())
		flags |= FLAG_TEMPERATURE_SENSITIVE

		if(temperature >= material.boiling_point)
			material_state = STATE_GAS
		else if(temperature >= material.melting_point)
			material_state = STATE_LIQUID
		else
			material_state = STATE_SOLID

	UpdateValues()
	..(newloc)

/obj/proc/UpdateValues()
	return

/obj/proc/Process()
	return

/obj/IsSolid()
	return (material_state == STATE_SOLID || material_state == STATE_POWDER)
