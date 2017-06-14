/datum/objective/assassinate
	text = "A contract has been issued for TARGET. Kill them."
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
		text = "A contract has been issued for \the [target], [target.role.job.GetTitle()]. Kill [target.Them()]."

/datum/objective/assassinate/Completed()
	return (!target || target.dead)
