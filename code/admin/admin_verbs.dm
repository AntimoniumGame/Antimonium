/proc/InitializeAdminPermissions()
	for(var/ptype in typesof(/datum/admin_permissions)-/datum/admin_permissions)
		var/datum/admin_permissions/perm = new ptype()
		glob.admin_permission_datums += perm
		glob.admin_permissions_by_flag["[perm.associated_permission]"] = perm

/datum/admin_permissions
	var/associated_permission = 0
	var/list/verbs = list()

/datum/admin_permissions/proc/AddToClient(var/client/player)
	player.verbs |= verbs

/datum/admin_permissions/proc/RemoveFromClient(var/client/player)
	player.verbs -= verbs
