/datum/objective/escape
	text = "Escape the island with your life."

/datum/objective/escape/Completed()
	return (holder && holder.mob && !holder.mob.dead)
