/datum/effect/cumulative
	var/value = 0

/datum/effect/cumulative/Tick()
	if(ticks > 1)
		value++
		ticks--
		if(ticks <= 0)
			QDel(src, "effect expired")
	else if(value > 0)
		value--

/datum/effect/cumulative/New(var/mob/_owner, var/_effect_name, var/_ticks, var/initial_value)
	..()
	if(!isnull(initial_value))
		value = initial_value

/datum/effect/cumulative/GetEffectPower()
	return value
