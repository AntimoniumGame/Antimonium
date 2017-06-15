/obj/item/consumable
	name = "bread"
	icon = 'icons/objects/items/food/food.dmi'
	default_material_path = /datum/material/herb/wheat
	appearance_flags = NO_CLIENT_COLOR

	var/eaten_sound
	var/bites_left = 3
	var/trash_path
	var/value_per_bite = 10

	var/nutrition = 5

/obj/item/consumable/Use(var/mob/user)

	if(user.stomach.len > 5) // arbitrary
		user.Notify("<span class='warning'>You are much too full to fit anything else into your stomach.</span>")
		return

	bites_left--
	new /datum/effect/consumed(user, name, value_per_bite, src)
	if(eaten_sound)
		PlayLocalSound(user, eaten_sound, 75)
	if(bites_left >= 1)
		ShowEatenMessage(user)
	else
		user.DropItem(src)
		ShowFinishMessage(user)
		if(trash_path)
			new trash_path(get_turf(user))
		QDel(src)
	return TRUE

/obj/item/consumable/proc/ShowEatenMessage(var/mob/user)
	user.NotifyNearby("<span class='notice'>\The [user] takes a bite out of \the [src].</span>")

/obj/item/consumable/proc/ShowFinishMessage(var/mob/user)
	user.NotifyNearby("<span class='notice'>\The [user] finishes eating \the [src].</span>")
