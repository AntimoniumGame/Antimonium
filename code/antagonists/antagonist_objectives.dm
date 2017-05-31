/datum/objective
	var/text = "Be a jerk to some guy."
	var/datum/antagonist/antagonist
	var/datum/role/holder

/datum/objective/New(var/datum/role/_holder, var/datum/antagonist/_antagonist)
	holder = _holder
	antagonist = _antagonist
	SetObjective()

/datum/objective/proc/SetObjective()
	return

/datum/objective/proc/Completed()
	return TRUE
