/mob
	var/unconsciousness = 0

/mob/proc/IsConscious()
	return unconsciousness <= 0

/mob/proc/SetUnconscious(var/amt)
	unconsciousness += amt
	if(!IsConscious())
		PassOut(outside_life_loop = TRUE)

/mob/proc/PassOut(var/outside_life_loop)
	if(!prone)
		ToggleProne()
	if(outside_life_loop)
		UpdateVision()
