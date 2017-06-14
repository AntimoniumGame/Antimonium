/datum/objective/cultist_victory
	text = "Swell the cult ranks to outnumber the villagers of the hamlet, either by murder or conversion."

/datum/objective/cultist_victory/Completed()

	var/cultist_count = 0
	var/villager_count = 0

	for(var/thing in clients)
		var/client/C = thing
		if(istype(C.mob, /mob/human) && !C.mob.dead && !isnull(C.role.job))
			if(antagonist in C.role.antagonist_roles)
				cultist_count++
			else
				villager_count++

	return cultist_count > villager_count
