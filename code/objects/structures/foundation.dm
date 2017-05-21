/obj/structure/foundation
	name = "foundation"
	icon = 'icons/objects/structures/foundation.dmi'
	var/build_type

/obj/structure/foundation/New(var/newloc, var/material_path, var/_build_type)
	build_type = _build_type
	..(newloc, material_path)
