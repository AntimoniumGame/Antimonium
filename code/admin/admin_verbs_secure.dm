/datum/admin_permissions/secure
	associated_permission = PERMISSIONS_SECURE
	verbs = list(
		/client/proc/AddAdmin,
		/client/proc/RemoveAdmin,
		/proc/InitializeAdminDatabase
		)

// These are placeholders for now, hence crudity.
/client/proc/AddAdmin()

	set name = "Add Admin"
	set category = "Secure"

	var/enter_ckey = ckey(input("Enter a ckey.") as text|null)
	if(!enter_ckey)
		return

	var/client/modifying
	for(var/client/player in _glob.clients)
		if(player.ckey == enter_ckey)
			modifying = player
			break

	var/existing_admin = FALSE
	if(_glob.admins[enter_ckey])
		existing_admin = TRUE
		if(modifying)
			modifying.SetAdminPermissions()
		_glob.admins[enter_ckey] = null
		_glob.admins -= enter_ckey

	var/enter_perm = input("Enter a numerical combined permission flag.") as num|null
	if(isnull(enter_perm))
		return

	var/enter_title = input("Enter a title.") as text|null
	if(!enter_title)
		return

	_glob.admins[enter_ckey] = new /datum/admin_rank(enter_ckey, enter_perm, enter_title)
	Anotify("Updated rank for [enter_ckey] to [enter_perm] - [enter_title].")
	if(modifying)
		modifying.SetAdminPermissions(_glob.admins[enter_ckey])

	if(existing_admin)
		UpdateAdminDatabase(enter_ckey, enter_perm, enter_title)
	else
		AddToAdminDatabase(enter_ckey, enter_perm, enter_title)

/client/proc/RemoveAdmin()

	set name = "Remove Admin"
	set category = "Secure"

	var/enter_ckey = ckey(input("Enter a ckey.") as text|null)
	if(!enter_ckey)
		return

	if(_glob.admins[enter_ckey])
		_glob.admins[enter_ckey] = null
		_glob.admins -= enter_ckey
	for(var/client/player in _glob.clients)
		if(player.ckey == enter_ckey)
			player.SetAdminPermissions()
			break

	RemoveFromAdminDatabase(enter_ckey)
