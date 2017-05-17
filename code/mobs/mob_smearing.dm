/mob
	var/mob/smeared_with = list()

/mob/proc/smear_with(var/datum/material/smearing, var/amount)
	if(smeared_with[smearing])
		smeared_with[smearing] += amount
	else
		smeared_with[smearing] = amount
