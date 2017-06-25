// Eaten food.
/datum/effect/consumed
	var/nutrition = 0

/datum/effect/consumed/New(var/mob/_owner, var/_effect_name, var/_ticks, var/obj/item/consumable/_donor)
	..()
	if(istype(_donor))
		nutrition = _donor.nutrition

/datum/effect/consumed/Tick()
	if(!isnull(nutrition) && nutrition != 0 && (owner.hunger+nutrition) <= 100)
		owner.hunger += nutrition
	..()
