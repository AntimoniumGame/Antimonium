/datum/admin_permissions/secure
	associated_permission = PERMISSIONS_SECURE
	verbs = list(
		/client/proc/add_admin,
		/client/proc/remove_admin,
		/proc/initialize_admin_database
		)

// These are placeholders for now, hence crudity.
/client/proc/add_admin()

	set name = "Add Admin"
	set category = "Secure"

	var/enter_ckey = ckey(input("Enter a ckey.") as text|null)
	if(!enter_ckey)
		return

	var/client/modifying
	for(var/client/player in clients)
		if(player.ckey == enter_ckey)
			modifying = player
			break

	var/existing_admin = FALSE
	if(admins[enter_ckey])
		existing_admin = TRUE
		modifying.set_admin_permissions()
		admins[enter_ckey] = null
		admins -= enter_ckey

	var/enter_perm = input("Enter a numerical combined permission flag.") as num|null
	if(isnull(enter_perm))
		return

	var/enter_title = input("Enter a title.") as text|null
	if(!enter_title)
		return

	admins[enter_ckey] = new /datum/admin_rank(enter_ckey, enter_perm, enter_title)
	anotify("Updated rank for [enter_ckey] to [enter_perm] - [enter_title].")
	if(modifying)
		modifying.set_admin_permissions(admins[enter_ckey])

	if(existing_admin)
		update_admin_database(enter_ckey, enter_perm, enter_title)
	else
		add_to_admin_database(enter_ckey, enter_perm, enter_title)

/client/proc/remove_admin()

	set name = "Remove Admin"
	set category = "Secure"

	var/enter_ckey = ckey(input("Enter a ckey.") as text|null)
	if(!enter_ckey)
		return

	if(admins[enter_ckey])
		admins[enter_ckey] = null
		admins -= enter_ckey
	for(var/client/player in clients)
		if(player.ckey == enter_ckey)
			player.set_admin_permissions()
			break

	remove_from_admin_database(enter_ckey)
