/obj/item/weapon
	default_material_path = /datum/material/metal/iron
	height = 20
	width = 5
	length = 5
	var/strike_area = 3
	var/datum/material/secondary_material

/obj/item/weapon/GetContactArea()
	return strike_area

/obj/item/weapon/New(var/newloc, var/material_path, var/secondary_material_path = /datum/material/wood)
	..(newloc, material_path)
	secondary_material = GetUniqueDataByPath(secondary_material_path)

/obj/item/weapon/ExaminedBy(var/mob/user)
	if(..(user) && !user.HasEffect(EFFECT_BLINDED))
		user.Notify("<span class='notice'>The handle is made of [secondary_material.GetName()].</span>")
