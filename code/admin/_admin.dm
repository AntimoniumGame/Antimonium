var/database/admin_db
var/list/admins = list()

/proc/anotify(var/message, var/permission = PERMISSIONS_MODERATOR)
	for(var/client/player in clients)
		if(player.check_admin_permission(permission))
			player.notify("ADMIN: [message]")

/proc/initialize_admin_database()

	set name = "Reload Admin Database"
	set category = "Secure"

	// In case this is called at runtime.
	if(usr)
		clear_admins()
		anotify("[usr.key] is reloading admins.")

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
		anotify("SQL error - [query.Error()] - [query.ErrorMsg()]", PERMISSIONS_DEBUG)

	// Load admins.
	query = new("SELECT * FROM ranks")

	query.Execute(admin_db)
	if(query.Error() || query.ErrorMsg())
		anotify("SQL error - [query.Error()] - [query.ErrorMsg()]", PERMISSIONS_DEBUG)

	admins.Cut()
	while(query.NextRow())
		var/list/results = query.GetRowData()
		admins[results["ckey"]] = new /datum/admin_rank(results["ckey"], results["permissions"], results["title"])

	// Insert default admins if needed.
	for(var/admin in file2list("data/default_admins.txt"))
		admin = ckey(admin)
		if(!admins[admin])
			add_to_admin_database(admin, PERMISSIONS_DEFAULT, "a Default Administrator")
			admins[admin] = new /datum/admin_rank(admin, PERMISSIONS_DEFAULT, "a Default Administrator")

	// Refresh clients that are already on the server.
	update_admins()

/proc/update_admins()
	for(var/client/player in clients)
		player.set_admin_permissions(admins[player.ckey])

/proc/clear_admins()
	for(var/client/player in clients)
		player.set_admin_permissions(silent = TRUE)

/proc/add_to_admin_database(var/enter_ckey, var/enter_permissions, var/enter_title)
	var/database/query/query = new("INSERT INTO ranks VALUES (?,?,?);", enter_ckey, enter_permissions, enter_title)
	query.Execute(admin_db)
	if(query.Error() || query.ErrorMsg())
		anotify("SQL error - [query.Error()] - [query.ErrorMsg()]", PERMISSIONS_DEBUG)

/proc/update_admin_database(var/enter_ckey, var/enter_permissions, var/enter_title)
	var/database/query/query = new("UPDATE ranks SET permissions = ?, title = ? WHERE ckey == ?;", enter_permissions, enter_title, enter_ckey)
	query.Execute(admin_db)
	if(query.Error() || query.ErrorMsg())
		anotify("SQL error - [query.Error()] - [query.ErrorMsg()]", PERMISSIONS_DEBUG)

/proc/remove_from_admin_database(var/enter_ckey)
	var/database/query/query = new("DELETE * FROM ranks WHERE ckey == ?;", enter_ckey)
	query.Execute(admin_db)
	if(query.Error() || query.ErrorMsg())
		anotify("SQL error - [query.Error()] - [query.ErrorMsg()]", PERMISSIONS_DEBUG)
