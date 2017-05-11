/data/game_state/setup
	ident = GAME_SETTING_UP

/data/game_state/setup/init()
	spawn()
		mc = new()
	..()

/data/game_state/setup/start()
	switch_game_state(/data/game_state/waiting)

/data/game_state/setup/end()
	to_chat(world, "<b>Game setup complete!</b>")

/data/game_state/setup/on_login(var/client/player)
	to_chat(world, "<b>The game is setting up.</b>")
