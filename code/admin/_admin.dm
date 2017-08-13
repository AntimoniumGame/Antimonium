var/database/admin_db
var/list/admins = list()

/proc/Anotify(var/message, var/permission = PERMISSIONS_MODERATOR)
	for(var/client/player in clients)
		if(player.CheckAdminPermission(permission))
			player.Anotify(message)

/proc/Dnotify(var/message, var/permission = PERMISSIONS_DEBUG)
	for(var/client/player in clients)
		if(player.CheckAdminPermission(permission))
			player.Dnotify(message)

/proc/InitializeAdminDatabase()

	set name = "Reload Admin Database"
	set category = "Secure"

	// In case this is called at runtime.
	if(usr)
		ClearAdmins()
		Anotify("[usr.key] is reloading admins.")

	// Init/load DB
	admin_db = new("data/admins.db")

	// Init schema if needed
	var/database/query/query = new(
		"CREATE TABLE IF NOT EXISTS ranks ( \
		ckey TEXT PRIMARY KEY NOT NULL UNIQUE, \
		permissions INTEGER NOT NULL DEFAULT 0, \
		title TEXT NOT NULL DEFAULT 'a Default Administrator' \
		);")

	query.Execute(admin_db)
	if(query.Error() || query.ErrorMsg())
		Anotify("SQL error - initialize_admin_database 1 - [query.Error()] - [query.ErrorMsg()]", PERMISSIONS_DEBUG)

	// Load admins.
	query = new("SELECT * FROM ranks;")

	query.Execute(admin_db)
	if(query.Error() || query.ErrorMsg())
		Anotify("SQL error - initialize_admin_database 2 - [query.Error()] - [query.ErrorMsg()]", PERMISSIONS_DEBUG)

	admins.Cut()
	while(query.NextRow())
		var/list/results = query.GetRowData()
		admins[results["ckey"]] = new /datum/admin_rank(results["ckey"], results["permissions"], results["title"])

	// Insert default admins if needed.
	for(var/admin in File2List("data/default_admins.txt"))
		admin = ckey(admin)
		if(!admins[admin])
			AddToAdminDatabase(admin, PERMISSIONS_DEFAULT, "a Default Administrator")
			admins[admin] = new /datum/admin_rank(admin, PERMISSIONS_DEFAULT, "a Default Administrator")

	// Refresh clients that are already on the server.
	UpdateAdmins()

/proc/UpdateAdmins()
	for(var/client/player in clients)
		player.SetAdminPermissions(admins[player.ckey])

/proc/ClearAdmins()
	for(var/client/player in clients)
		player.SetAdminPermissions(silent = TRUE)

/proc/AddToAdminDatabase(var/enter_ckey, var/enter_permissions, var/enter_title)
	var/database/query/query = new("INSERT INTO ranks VALUES (?,?,?);", enter_ckey, enter_permissions, enter_title)
	query.Execute(admin_db)
	if(query.Error() || query.ErrorMsg())
		Anotify("SQL error - add_to_admin_database - [query.Error()] - [query.ErrorMsg()]", PERMISSIONS_DEBUG)

/proc/UpdateAdminDatabase(var/enter_ckey, var/enter_permissions, var/enter_title)
	var/database/query/query = new("UPDATE ranks SET permissions = ?, title = ? WHERE ckey == ?;", enter_permissions, enter_title, enter_ckey)
	query.Execute(admin_db)
	if(query.Error() || query.ErrorMsg())
		Anotify("SQL error - update_admin_database - [query.Error()] - [query.ErrorMsg()]", PERMISSIONS_DEBUG)

/proc/RemoveFromAdminDatabase(var/enter_ckey)
	var/database/query/query = new("DELETE * FROM ranks WHERE ckey == ?;", enter_ckey)
	query.Execute(admin_db)
	if(query.Error() || query.ErrorMsg())
		Anotify("SQL error - remove_from_admin_database - [query.Error()] - [query.ErrorMsg()]", PERMISSIONS_DEBUG)
