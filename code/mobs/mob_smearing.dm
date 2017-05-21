/mob
	var/mob/smeared_with = list()

/mob/proc/SmearWith(var/datum/material/smearing, var/amount)
	if(flags & FLAG_SIMULATED)
		if(smeared_with[smearing])
			smeared_with[smearing] += amount
		else
			smeared_with[smearing] = amount
