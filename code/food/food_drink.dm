/obj/item/consumable/drink
	name = "drink"

/obj/item/consumable/drink/ShowEatenMessage(var/mob/user)
	user.NotifyNearby("\The [user] takes a swig from \the [src].")

/obj/item/consumable/drink/ShowFinishMessage(var/mob/user)
	user.NotifyNearby("\The [user] drains the dregs of \the [src].")
