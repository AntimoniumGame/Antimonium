/mob
	var/list/effects = list()

/mob/proc/HandleEffects()
	for(var/thing in effects)
		var/datum/effect/effect = effects[thing]
		if(!effect)
			effects[thing] = null
			effects -= thing
			effects -= null
		else
			effect.Tick()

/mob/proc/HasEffect(var/effect_id)
	return effects[effect_id]

/mob/proc/AddEffect(var/effect_path, var/effect_id, var/duration, var/additional_data)
	var/datum/effect/effect = effects[effect_id]
	if(effect)
		effect.UpdateEffect(duration, additional_data)
	else
		effects[effect_id] = new effect_path(src, effect_id, duration, additional_data)

/mob/proc/GetEffectPower(var/effect_id)
	var/datum/effect/effect = HasEffect(effect_id)
	return effect ? max(0,effect.GetEffectPower()) : 0
