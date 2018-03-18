/obj/item/limb/head
	var/eye_colour
	var/image/hair_image_mob
	var/image/hair_image_world
	var/image/eye_image_mob
	var/image/eye_image_world

/obj/item/limb/head/proc/SetHairStyle(var/hair_type, var/defer_icon_update)
	if(hair_image_mob)   QDel(hair_image_mob)
	if(hair_image_world) QDel(hair_image_world)
	if(hair_type && hair_type != "Bald" && _glob.hair_styles[hair_type])
		hair_image_mob =   image(icon = _glob.hair_styles[hair_type], icon_state = "mob")
		hair_image_world = image(icon = _glob.hair_styles[hair_type], icon_state = "world")
	if(!defer_icon_update) UpdateIcon()

/obj/item/limb/head/proc/SetEyeColour(var/eye_colour, var/defer_icon_update)
	if(!eye_image_mob)      eye_image_mob = image(icon = icon, icon_state = "eyes_mob")
	eye_image_mob.color =   eye_colour
	if(!eye_image_world)    eye_image_world = image(icon = icon, icon_state = "eyes_world")
	eye_image_world.color = eye_colour
	if(!defer_icon_update) UpdateIcon()

/obj/item/limb/head/UpdateIcon()
	..()
	var/list/overlays_to_add = list()
	if(hair_image_world) overlays_to_add += hair_image_world
	overlays_to_add += eye_image_world
	overlays += overlays_to_add

/obj/item/limb/head/GetWornIcon(var/inventory_slot)
	. = ..()
	if(inventory_slot == "mob" || inventory_slot == "world")
		var/list/overlays_to_add = list()
		var/image/I = .
		if(hair_image_world && hair_image_mob) overlays_to_add += (inventory_slot == "world" ? hair_image_world : hair_image_mob)
		overlays_to_add += (inventory_slot == "world" ? eye_image_world : eye_image_mob)
		I.overlays += overlays_to_add
