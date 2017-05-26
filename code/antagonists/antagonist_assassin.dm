/datum/antagonist/assassin
	role_name = "\improper Assassin"
	welcome_text = "You are a devotee of an ancient guild of assassins. Find and kill your target."

/datum/antagonist/assassin/GenerateObjectives(var/datum/role/generating)
	generating.objectives += new /datum/objective(generating, src)
