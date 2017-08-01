// Reagents.
/datum/effect/consumed_reagent
	var/datum/material/material

/datum/effect/consumed_reagent/New(var/mob/_owner, var/_effect_name, var/_ticks, var/datum/material/_donor)
	..()
	if(istype(_donor))
		material = _donor

/datum/effect/consumed_reagent/Tick()
	material.HandleConsumedEffects(owner)
	..()
