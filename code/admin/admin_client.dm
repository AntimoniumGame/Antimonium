/client
	var/datum/admin_rank/admin_permissions

/client/proc/AdminSetup()
	set waitfor = 0
	if(_glob.admins)
		SetAdminPermissions(_glob.admins[ckey])
	DevPanel()

/client/proc/SetAdminPermissions(var/datum/admin_rank/_rank, var/silent = FALSE)

	// Clear out everything, be thorough.
	if(admin_permissions)
		for(var/datum/admin_permissions/perm in _glob.admin_permission_datums)
			perm.RemoveFromClient(src, silent)

	var/last_rank = admin_permissions ? admin_permissions.title : null
	admin_permissions = _rank
	if(!silent && last_rank != (admin_permissions ? admin_permissions.title : null))
		Anotify("You are now listed as <b>[admin_permissions ? admin_permissions.title : "a player"]</b>.")

	if(admin_permissions)
		for(var/datum/admin_permissions/perm in _glob.admin_permission_datums)
			if(admin_permissions.permissions & perm.associated_permission)
				perm.AddToClient(src, silent)
	else
		_glob.admins[ckey] = null
		_glob.admins -= ckey

/client/proc/CheckAdminPermission(var/perm)
	return (admin_permissions && (admin_permissions.permissions & perm))

/client/Stat()
	..()
	if(CheckAdminPermission(PERMISSIONS_DEBUG))
		QUEUE_END // push this to the back of the queue for an accurate tick usage count
		stat("Server Load: ", "[floor(world.tick_usage)]%")
