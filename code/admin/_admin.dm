/proc/MassAnotify(var/message, var/permission = PERMISSIONS_MODERATOR)
	for(var/client/player in _glob.clients)
		if(player.CheckAdminPermission(permission))
			player.Anotify(message)

/proc/MassDnotify(var/message, var/permission = PERMISSIONS_DEBUG)
	for(var/client/player in _glob.clients)
		if(player.CheckAdminPermission(permission))
			player.Dnotify(message)

/proc/InitializeAdminDatabase()

	set name = "Reload Admin Database"
	set category = "Secure"

	// In case this is called at runtime.
	if(usr)
		ClearAdmins()
		MassAnotify("[usr.key] is reloading admins.")

	// Init/load DB
	_glob.admin_db = new("data/admins.db")

	// Init schema if needed
	var/database/query/query = new(
		"CREATE TABLE IF NOT EXISTS ranks ( \
		ckey TEXT PRIMARY KEY NOT NULL UNIQUE, \
		permissions INTEGER NOT NULL DEFAULT 0, \
		title TEXT NOT NULL DEFAULT 'a Default Administrator' \
		);")

	query.Execute(_glob.admin_db)
	if(query.Error() || query.ErrorMsg())
		MassAnotify("SQL error - initialize_admin_database 1 - [query.Error()] - [query.ErrorMsg()]", PERMISSIONS_DEBUG)

	// Load admins.
	query = new("SELECT * FROM ranks;")

	query.Execute(_glob.admin_db)
	if(query.Error() || query.ErrorMsg())
		MassAnotify("SQL error - initialize_admin_database 2 - [query.Error()] - [query.ErrorMsg()]", PERMISSIONS_DEBUG)

	_glob.admins.Cut()
	while(query.NextRow())
		var/list/results = query.GetRowData()
		_glob.admins[results["ckey"]] = new /datum/admin_rank(results["ckey"], results["permissions"], results["title"])

	// Insert default admins if needed.
	for(var/admin in File2List("data/default_admins.txt"))
		admin = ckey(admin)
		if(!_glob.admins[admin])
			AddToAdminDatabase(admin, PERMISSIONS_DEFAULT, "a Default Administrator")
			_glob.admins[admin] = new /datum/admin_rank(admin, PERMISSIONS_DEFAULT, "a Default Administrator")

	// Refresh clients that are already on the server.
	UpdateAdmins()

/proc/UpdateAdmins()
	for(var/client/player in _glob.clients)
		player.SetAdminPermissions(_glob.admins[player.ckey])

/proc/ClearAdmins()
	for(var/client/player in _glob.clients)
		player.SetAdminPermissions(silent = TRUE)

/proc/AddToAdminDatabase(var/enter_ckey, var/enter_permissions, var/enter_title)
	var/database/query/query = new("INSERT INTO ranks VALUES (?,?,?);", enter_ckey, enter_permissions, enter_title)
	query.Execute(_glob.admin_db)
	if(query.Error() || query.ErrorMsg())
		MassAnotify("SQL error - add_to_admin_database - [query.Error()] - [query.ErrorMsg()]", PERMISSIONS_DEBUG)

/proc/UpdateAdminDatabase(var/enter_ckey, var/enter_permissions, var/enter_title)
	var/database/query/query = new("UPDATE ranks SET permissions = ?, title = ? WHERE ckey == ?;", enter_permissions, enter_title, enter_ckey)
	query.Execute(_glob.admin_db)
	if(query.Error() || query.ErrorMsg())
		MassAnotify("SQL error - update_admin_database - [query.Error()] - [query.ErrorMsg()]", PERMISSIONS_DEBUG)

/proc/RemoveFromAdminDatabase(var/enter_ckey)
	var/database/query/query = new("DELETE * FROM ranks WHERE ckey == ?;", enter_ckey)
	query.Execute(_glob.admin_db)
	if(query.Error() || query.ErrorMsg())
		MassAnotify("SQL error - remove_from_admin_database - [query.Error()] - [query.ErrorMsg()]", PERMISSIONS_DEBUG)
