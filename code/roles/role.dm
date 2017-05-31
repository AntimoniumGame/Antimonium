var/list/all_roles = list()

/client/New()
	. = ..()
	for(var/thing in all_roles)
		var/datum/role/crole = thing
		if(crole.ckey == ckey)
			role = crole
			role.mob = mob
			mob.role = role
			break
	if(!role)
		role = new(src)

/mob/Login()
	. = ..()
	if(!client)
		return
	if(role && role.ckey == client.ckey && !client.role)
		client.role = role
	else if(client.role)
		role = client.role
	else
		role = new(client)

/client
	var/datum/role/role

/mob
	var/datum/role/role

/datum/role
	var/ckey
	var/client/holder
	var/mob/mob
	var/datum/job/job
	var/list/antagonist_roles = list()
	var/list/objectives = list()

/datum/role/New(var/client/_holder)
	..()
	holder = _holder
	ckey = holder.ckey
	mob = holder.mob
	all_roles += src

/datum/role/Destroy()
	all_roles -= src
	. = ..()
