/datum/material/water/alcohol
	general_name = "beer"
	liquid_name = "beer"
	solid_name = null
	gas_name = null
	colour = PALE_BROWN
	var/drunk_power = 1

/datum/material/water/alcohol/HandleConsumedEffects(var/mob/consumer)
	consumer.AddEffect(/datum/effect/cumulative, EFFECT_DIZZY, additional_data = 1 * drunk_power)
	consumer.AddEffect(/datum/effect/cumulative, EFFECT_CONFUSED, additional_data = -10 * drunk_power)
	consumer.AddEffect(/datum/effect/cumulative, EFFECT_SLURRING, additional_data = -20 * drunk_power)

/datum/material/water/alcohol/wine
	general_name = "wine"
	liquid_name = "wine"
	colour = DARK_RED
	drunk_power = 3
