/datum/material/water/alcohol
	general_name = "beer"
	liquid_name = "beer"
	solid_name = null
	gas_name = null
	colour = PALE_BROWN
	var/drunk_power = 1

/datum/material/water/alcohol/HandleConsumedEffects(var/mob/consumer)
	consumer.AddEffect(/datum/effect/cumulative, EFFECT_DIZZY, 0)
	consumer.AddEffect(/datum/effect/cumulative, EFFECT_CONFUSED, -10)
	consumer.AddEffect(/datum/effect/cumulative, EFFECT_SLURRING, -20)

/datum/material/water/alcohol/poisoned