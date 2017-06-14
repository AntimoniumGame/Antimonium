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
