/datum/effect
	var/mob/owner
	var/effect_name
	var/ticks

/datum/effect/New(var/mob/_owner, var/_effect_name, var/_ticks)
	..()
	effect_name = _effect_name
	owner = _owner
	ticks = _ticks

/datum/effect/Destroy()
	if(owner)
		owner.effects[effect_name] = null
		owner.effects -= effect_name
		owner.effects -= null
		owner = null
	. = ..()

/datum/effect/proc/Tick()
	ticks--
	if(ticks<=0)
		QDel(src)

/datum/effect/proc/UpdateEffect(var/_duration, var/_additional_data)
	ticks = max(ticks, _duration)

/datum/effect/proc/GetEffectPower()
	return ticks
