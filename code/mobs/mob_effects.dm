/mob
	var/list/skin = list()
	var/list/consumable_effects = list()
	var/hunger = 100

/mob/proc/AddEffect(var/effect_path, var/duration)

/mob/proc/HandleConsumableEffects()
	consumable_effects = list()

	var/list/effects = skin.Copy()
	var/list/organs = GetHealthyOrgansByKey(ORGAN_STOMACH) + GetHealthyOrgansByKey(ORGAN_LUNG)

	for(var/thing in organs)
		var/obj/item/organ/organ = thing
		if(istype(organ))
			effects += organ.effects

	for(var/thing in effects)
		var/datum/effect/consumed = thing
		consumed.Tick()
