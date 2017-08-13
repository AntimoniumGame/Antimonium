var/list/job_datums = list()
var/list/high_priority_jobs = list()
var/list/low_priority_jobs = list()
var/datum/job/default_latejoin_role

/proc/InitializeJobs()
	for(var/jtype in typesof(/datum/job)-/datum/job)
		var/datum/job/job = new jtype()
		job_datums += job
		if(job.minimum_slots > 0)
			high_priority_jobs += job
		else
			low_priority_jobs += job

	default_latejoin_role = new /datum/job

	// Bit of extra randomness, why not.
	high_priority_jobs = shuffle(high_priority_jobs)
	low_priority_jobs = shuffle(low_priority_jobs)

/datum/job/New()
	..()
	if(ispath(outfit))
		outfit = GetUniqueDataByPath(outfit)

/datum/job
	var/name = "Drifter"
	var/name_female
	var/commander = "nobody"
	var/welcome_text = "You roam wherever the roads take you."
	var/minimum_slots = -1
	var/maximum_slots = -1
	var/filled_slots = 0
	var/force_mob_type = /mob/human
	var/datum/outfit/outfit = /datum/outfit/town

/datum/job/proc/GetTitle(var/mob/checking)
	var/the = (maximum_slots == 1 ? "the" : "a")
	return ((name_female && checking.gender == FEMALE) ? "[the] [name_female]" : "[the] [name]")

/datum/job/proc/Welcome(var/mob/welcoming)
	welcoming.Notify("<span class='notice'>You are <span class='alert'><b>[GetTitle(welcoming)]</span></b>!</span>")
	welcoming.Notify("<span class='notice'>You answer to <span class='alert'><b>[commander]</b></span>.</span>")
	welcoming.Notify("<span class='notice'>[welcome_text]</span>")
	welcoming.role.job = src

/datum/job/proc/Equip(var/mob/equipping)
	if(equipping.type != force_mob_type)
		var/mob/new_mob = new force_mob_type()
		equipping.TransferControlTo(new_mob)
		QDel(equipping)
		equipping = new_mob

	if(istype(outfit))
		outfit.EquipTo(equipping)

	equipping.name = equipping.key
	return equipping

/datum/job/proc/Place(var/mob/placing)
	placing.ForceMove(locate(3,3,2))
