/datum/antagonist/assassin
	role_name = "\improper Assassin"
	welcome_text = "You are a devotee of an ancient guild of assassins. Find and kill your target."
	maximum_spawn_count = 0.1

/datum/antagonist/assassin/GenerateObjectives(var/datum/role/generating)
	generating.objectives += new /datum/objective/assassinate(generating, src)
	generating.objectives += new /datum/objective/escape(generating, src)
