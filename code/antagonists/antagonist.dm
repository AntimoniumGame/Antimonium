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
	welcoming.Notify("You are <b>\a [role_name]<b>!")
	welcoming.Notify("<i>[welcome_text]</i>")

/datum/antagonist/proc/Equip(var/mob/equipping)
	return

/datum/antagonist/proc/Farewell(var/mob/farewelling)
	farewelling.Notify("You are no longer \a [role_name]!")

/datum/antagonist/proc/CheckSuccess(var/datum/role/checking)
	var/list/results = list()
	var/overall_success = TRUE
	var/i = 0
	for(var/thing in checking.objectives)
		var/datum/objective/o = thing
		if(o.antagonist == src)
			i++
			if(o.Completed())
				results += "#[i]. [o.text] Success!"
			else
				results += "#[i]. [o.text] Failure."
				overall_success = FALSE

	if(overall_success)
		results += "<b>\The [role_name] was successful!</b>"
	else
		results += "<b>\The [role_name] failed!</b>"
	return results
