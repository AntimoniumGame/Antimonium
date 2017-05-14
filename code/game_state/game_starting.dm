/data/game_state/starting
	ident = GAME_STARTING

/data/game_state/starting/start()
	switch_game_state(/data/game_state/running)

/data/game_state/starting/end()
	to_chat(world, "<b>The game is starting!</b>")

/data/game_state/starting/on_login(var/client/player)
	to_chat(world, "<b>The game is starting!</b>")
