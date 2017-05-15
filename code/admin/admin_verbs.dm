var/list/admin_permission_datums = list()
var/list/admin_permissions_by_flag = list()

/proc/initialize_admin_permissions()
	for(var/ptype in typesof(/datum/admin_permissions)-/datum/admin_permissions)
		var/datum/admin_permissions/perm = new ptype()
		admin_permission_datums += perm
		admin_permissions_by_flag["[perm.associated_permission]"] = perm

/datum/admin_permissions
	var/associated_permission = 0
	var/list/verbs = list()

/datum/admin_permissions/proc/add_to_client(var/client/player)
	player.verbs |= verbs

/datum/admin_permissions/proc/remove_from_client(var/client/player)
	player.verbs -= verbs
