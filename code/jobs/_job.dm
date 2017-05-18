var/list/job_datums = list()
var/list/job_datums_by_path = list()

/proc/initialize_jobs()
	for(var/jtype in typesof(/datum/job)-/datum/job)
		var/datum/job/job = new jtype()
		job_datums += job
		job_datums_by_path[jtype] = job

/datum/job
	var/name = "Jobber"
	var/name_female
	var/the = "the"
	var/commander = "nobody"
	var/welcome_text = "You do the thing. You do it well."
	var/maximum_slots = -1

/datum/job/proc/welcome(var/mob/welcoming)
	if(name_female && welcoming.gender == FEMALE)
		welcoming.notify("You are <b>[the] [name_female]</b>!")
	else
		welcoming.notify("<br><br>You are <b>[the] [name]</b>!</br>")
	welcoming.notify("You answer to <b>[commander]</b>.")
	welcoming.notify("[welcome_text]")

/datum/job/proc/equip(var/mob/equipping)
	return
