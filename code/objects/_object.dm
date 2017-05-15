/obj
	icon = 'icons/objects/object.dmi'
	layer = ITEM_LAYER

	var/datum/material/material
	var/default_material_path

/obj/New(var/newloc, var/material_path)

	if(!ispath(material_path) && ispath(default_material_path))
		material_path = default_material_path
	if(ispath(material_path))
		material = get_unique_data_by_path(material_path)
	update_values()
	..(newloc)

/obj/proc/update_values()
	return

/obj/proc/process()
	return