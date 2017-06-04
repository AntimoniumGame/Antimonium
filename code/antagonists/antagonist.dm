var/list/antagonist_datums = list()

/proc/InitializeAntagonists()
	for(var/atype in typesof(/datum/antagonist)-/datum/antagonist)
		antagonist_datums += new atype()

/datum/antagonist
	var/role_name
	var/welcome_text
	var/list/members = list()

/datum/antagonist/proc/AddAntagonist(var/datum/role/adding)
	if(adding in members)
		return FALSE
	members += adding
	adding.antagonist_roles |= src
	GenerateObjectives(adding)
	Welcome(adding.mob)
	Equip(adding.mob)
	return TRUE

/datum/antagonist/proc/RemoveAntagonist(var/datum/role/removing)
	if(!(removing in members))
		return FALSE
	members -= removing
	removing.antagonist_roles -= src
	Farewell(removing.mob)
	return TRUE

/datum/antagonist/proc/GenerateObjectives(var/datum/role/generating)
	return

/datum/antagonist/proc/Welcome(var/mob/welcoming)
	welcoming.Notify("<span class='notice'>You are <span class='alert'><b>\a [role_name]<b></span>!</span>")
	welcoming.Notify("<span class='notice'><i>[welcome_text]</i></span>")

/datum/antagonist/proc/Equip(var/mob/equipping)
	return

/datum/antagonist/proc/Farewell(var/mob/farewelling)
	farewelling.Notify("<span class='alert'>You are <b>no longer</b> \a [role_name]!</span>")

/datum/antagonist/proc/CheckSuccess(var/datum/role/checking)
	var/list/results = list()
	var/overall_success = TRUE
	var/i = 0
	for(var/thing in checking.objectives)
		var/datum/objective/o = thing
		if(o.antagonist == src)
			i++
			if(o.Completed())
				results += "<span class='notice'>#[i]. [o.text]</span> <span class='notice'>Success</span>!"
			else
				results += "<span class='notice'>#[i]. [o.text]</span> <span class='warning'>Failure.</span>"
				overall_success = FALSE

	if(overall_success)
		results += "<span class='notice'><b>\The [role_name] was successful!</b></span>"
	else
		results += "<span class='warning'><b>\The [role_name] failed!</b></span>"
	return results
