var/list/antagonist_datums = list()

/proc/InitializeAntagonists()
	for(var/atype in typesof(/datum/antagonist)-/datum/antagonist)
		antagonist_datums += new atype()

/datum/antagonist
	var/role_name                      // Name of role.
	var/role_name_plural               // Name used for group antagonists.
	var/welcome_text                   // Text given to new members.
	var/list/members = list()          // List of role datums assigned to this antag role.
	var/maximum_spawn_count = 0.3      // Multiplicative modifier used to determine the maximum spawn count at roundstart.
	var/list/group_objectives = list() // What group obnjectives, if any, does this antagonist group have?
	var/role_count = 0                 // How many antagonists of this type have been assigned?
	var/override_job = FALSE           // Is this antagonist role assigned before or after job assignment?
	var/group_antagonist               // Whether or not this antagonist is displayed as a group role at roundend.
	var/list/restricted_roles = list() // Roles that cannot be assigned to this antagonist type.

/datum/antagonist/proc/CanAddAntagonist(var/datum/role/adding)
	return !(adding in members) && !(adding.job && (adding.job.type in restricted_roles))

/datum/antagonist/proc/AddAntagonist(var/datum/role/adding)
	if(!CanAddAntagonist(adding))
		return FALSE
	members += adding
	adding.antagonist_roles |= src
	GenerateObjectives(adding)
	Welcome(adding.mob)
	Equip(adding.mob)
	role_count++
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
	welcoming.Notify("<span class='notice'>[welcome_text]</span>")

/datum/antagonist/proc/Equip(var/mob/equipping)
	return equipping

/datum/antagonist/proc/Farewell(var/mob/farewelling)
	farewelling.Notify("<span class='alert'>You are <b>no longer</b> \a [role_name]!</span>")

/datum/antagonist/proc/CheckSuccess(var/datum/role/checking)
	var/list/results = list()
	var/overall_success = TRUE
	var/i = 0

	var/list/checking_objectives = group_objectives
	if(checking && !group_antagonist)
		checking_objectives = checking.objectives

	for(var/thing in checking_objectives)
		var/datum/objective/o = thing
		if(o.antagonist == src)
			i++
			if(o.Completed())
				results += "<span class='notice'>#[i]. [o.text]</span> <span class='notice'>Success</span>!"
			else
				results += "<span class='notice'>#[i]. [o.text]</span> <span class='warning'>Failure.</span>"
				overall_success = FALSE

	if(overall_success)
		results += "<span class='notice'><b>\The [group_antagonist ? "[role_name_plural] were" : "[role_name] was"] successful!</b></span>"
	else
		results += "<span class='warning'><b>\The [group_antagonist ? role_name_plural : role_name] failed!</b></span>"
	return results
