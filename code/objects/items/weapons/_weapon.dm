/obj/item/weapon
	default_material_path = /datum/material/metal/iron
	var/datum/material/secondary_material

/obj/item/weapon/New(var/newloc, var/material_path, var/secondary_material_path = /datum/material/wood)
	..(newloc, material_path)
	secondary_material = GetUniqueDataByPath(secondary_material_path)

/obj/item/weapon/ExaminedBy(var/mob/user)
	if(..(user))
		user.Notify("<span class='notice'>The handle is made of [secondary_material.GetName()].</span>")
