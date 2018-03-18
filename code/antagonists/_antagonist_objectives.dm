/datum/objective
	var/text = "Be a jerk to some guy."
	var/datum/antagonist/antagonist
	var/datum/role/holder

/datum/objective/New(var/datum/role/_holder, var/datum/antagonist/_antagonist)
	holder = _holder
	antagonist = _antagonist
	if(glob.game_state && glob.game_state.ident != GAME_STARTING)
		SetObjective()

/datum/objective/Destroy()
	antagonist = null
	if(holder && holder.objectives)
		holder.objectives -= src
		holder = null
	. = ..()

/datum/objective/proc/SetObjective()
	return

/datum/objective/proc/Completed()
	return TRUE

// General objectives.
/datum/objective/escape
	text = "Escape the island with your life."

/datum/objective/escape/Completed()
	return (holder && holder.mob && !holder.mob.dead)
