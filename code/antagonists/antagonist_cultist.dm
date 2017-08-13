/datum/antagonist/assassin
	role_name = "\improper Cultist"
	role_name_plural = "\improper Cultists"
	group_antagonist = TRUE
	welcome_text = "You have seen the true face of God, and serve That Which Waits unflinchingly. This hamlet must be forced to embrace your deity, or die."
	maximum_spawn_count = 0.3

/datum/antagonist/assassin/GenerateObjectives(var/datum/role/generating)
	if(!group_objectives.len)
		group_objectives += new /datum/objective/cultist_victory(null, src)
	generating.objectives = group_objectives

// Cultist objectives.
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
