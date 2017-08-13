/datum/antagonist/assassin
	role_name = "\improper Assassin"
	welcome_text = "You are a devotee of an ancient guild of assassins. Find and kill your target."
	maximum_spawn_count = 0.1

/datum/antagonist/assassin/GenerateObjectives(var/datum/role/generating)
	generating.objectives += new /datum/objective/assassinate(generating, src)
	generating.objectives += new /datum/objective/escape(generating, src)

// Assassin objectives.
/datum/objective/assassinate
	text = "A contract has been issued for TARGET. Kill them in whatever manner you wish."
	var/mob/target

/datum/objective/assassinate/SetObjective()
	for(var/thing in shuffle(clients.Copy()))
		var/client/C = thing
		if(istype(C.mob, /mob/human) && !isnull(C.role.job))
			target = C.mob
			break
	if(!target || target == holder.mob)
		QDel(src)
	else
		text = "A contract has been issued for \the [target], [target.role.job.GetTitle()]. Kill [target.Them()] in whatever manner you wish."

/datum/objective/assassinate/Completed()
	return (!target || target.dead)
