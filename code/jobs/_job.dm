var/list/job_datums = list()

/proc/InitializeJobs()
	for(var/jtype in typesof(/datum/job)-/datum/job)
		job_datums += new jtype()

/datum/job
	var/name = "Jobber"
	var/name_female
	var/the = "the"
	var/commander = "nobody"
	var/welcome_text = "You do the thing. You do it well."
	var/maximum_slots = -1

/datum/job/proc/GetTitle(var/mob/checking)
	return ((name_female && checking.gender == FEMALE) ? "[the] [name_female]" : "[the] [name]")

/datum/job/proc/Welcome(var/mob/welcoming)
	welcoming.Notify("You are <b>[GetTitle(welcoming)]</b>!")
	welcoming.Notify("You answer to <b>[commander]</b>.")
	welcoming.Notify("[welcome_text]")
	welcoming.role.job = src

/datum/job/proc/Equip(var/mob/equipping)
	return
