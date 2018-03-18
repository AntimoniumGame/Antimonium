/mob/Login()

	. = ..()

	MoveLoop()
	UpdateClient()

	if(role && role.ckey == client.ckey && !client.role)
		client.role = role
	else if(client.role)
		role = client.role
	else
		role = new(client)
	RefreshUI()
	spawn()
		DoFadein(src, 10)

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
	var/original_name

/datum/role/New(var/client/_holder)
	..()
	holder = _holder
	ckey = holder.ckey
	mob = holder.mob
	glob.all_roles += src
	original_name = "[mob]"

/datum/role/Destroy()
	glob.all_roles -= src
	. = ..()

/datum/role/proc/GetOriginalName()
	return original_name

/datum/role/proc/ShowObjectives()
	if(objectives.len)
		mob.Notify("You have the following objectives:")
		var/i = 0
		for(var/thing in objectives)
			var/datum/objective/o = thing
			i++
			mob.Notify("#[i]. [o.text]")
	else
		mob.Notify("You do not currently have any objectives.")