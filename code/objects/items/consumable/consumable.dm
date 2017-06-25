/obj/item/consumable
	name = "bread"
	icon = 'icons/objects/items/food/food.dmi'
	default_material_path = /datum/material/herb/wheat
	appearance_flags = NO_CLIENT_COLOR
	flags = FLAG_SIMULATED | FLAG_IS_EDIBLE | FLAG_THROWN_SPIN

	var/eaten_sound
	var/bites_left = 3
	var/trash_path
	var/value_per_bite = 10
	var/nutrition = 5

/obj/item/consumable/Eaten(var/mob/user)

	if(user.GetOrganEffectVolume(ORGAN_STOMACH) >= 5) // Arbitrary.
		user.Notify("<span class='warning'>You cannot fit anything else into your stomach.</span>")
		return TRUE

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
