/datum/game_state/setup
	ident = GAME_SETTING_UP

/datum/game_state/setup/init()
	spawn()
		mc = new()
		initialize_admin_permissions()
		initialize_admin_database()
		initialize_jobs()
	..()

/datum/game_state/setup/start()
	switch_game_state(/datum/game_state/waiting)

/datum/game_state/setup/end()
	to_chat(world, "<b>Game setup complete!</b>")

/datum/game_state/setup/on_login(var/client/player)
	to_chat(world, "<b>The game is setting up.</b>")
