/datum/effect
	var/mob/owner
	var/effect_name
	var/source_name
	var/ticks
	var/organ_key

/datum/effect/New(var/mob/_owner, var/_effect_name, var/_name, var/_ticks)
	..()
	owner = _owner
	source_name = _name
	effect_name = _effect_name
	ticks = _ticks

	if(organ_key)
		var/found_organ
		for(var/thing in owner.GetHealthyOrgansByKey(organ_key))
			var/obj/item/organ/organ = thing
			organ.effects += src
			found_organ = TRUE
			break
		if(!found_organ)
			QDel(src)
			return

/datum/effect/Destroy()
	if(owner && organ_key)
		var/list/organs = owner.GetOrgansByKey(organ_key)
		for(var/thing in organs)
			var/obj/item/organ/organ = thing
			if(src in organ.effects)
				organ.effects -= src
				break
	owner = null
	. = ..()

/datum/effect/proc/Tick()
	ticks--
	if(ticks<=0)
		QDel(src)

// Eaten food.
/datum/effect/consumed
	organ_key = ORGAN_STOMACH
	var/nutrition = 0

/datum/effect/consumed/New(var/mob/_owner, var/_name, var/_ticks, var/obj/item/consumable/_donor)
	..()
	nutrition = _donor.nutrition

/datum/effect/consumed/Tick()
	if(!isnull(nutrition) && nutrition != 0 && (owner.hunger+nutrition) <= 100)
		owner.hunger += nutrition
	..()

// Skin contaminants.
/datum/effect/smeared/New(var/mob/_owner, var/_name, var/_ticks)
	..()
	owner.skin += src

/datum/effect/smeared/Destroy()
	owner.skin -= src
	. = ..()

// Breathed gasses.
/datum/effect/breathed
	organ_key = ORGAN_LUNG
