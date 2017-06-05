/datum/effect
	var/mob/owner
	var/effect_name
	var/source_name
	var/ticks

/datum/effect/New(var/mob/_owner, var/_effect_name, var/_name, var/_ticks)
	..()
	owner = _owner
	source_name = _name
	effect_name = _effect_name
	ticks = _ticks

/datum/effect/Destroy()
	owner = null
	. = ..()

/datum/effect/proc/Tick()
	ticks--
	if(ticks<=0)
		QDel(src)

// Eaten food.
/datum/effect/consumed
	var/nutrition = 0

/datum/effect/consumed/New(var/mob/_owner, var/_name, var/_ticks, var/obj/item/consumable/_donor)
	..()
	owner.stomach += src
	nutrition = _donor.nutrition

/datum/effect/consumed/Tick()
	if(!isnull(nutrition) && nutrition != 0 && (owner.hunger+nutrition) <= 100)
		owner.hunger += nutrition
	..()

/datum/effect/consumed/Destroy()
	owner.stomach -= src
	. = ..()

// Skin contaminants.
/datum/effect/smeared/New(var/mob/_owner, var/_name, var/_ticks)
	..()
	owner.skin += src

/datum/effect/smeared/Destroy()
	owner.skin -= src
	. = ..()

// Breathed gasses.
/datum/effect/breathed/New(var/mob/_owner, var/_name, var/_ticks)
	..()
	owner.lungs += src

/datum/effect/breathed/Destroy()
	owner.lungs -= src
	. = ..()
