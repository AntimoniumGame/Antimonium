/datum/game_state/starting
	ident = GAME_STARTING

/datum/game_state/starting/start()
	switch_game_state(/datum/game_state/running)

/datum/game_state/starting/end()
	to_chat(world, "<b>The game is starting!</b>")

/datum/game_state/starting/on_login(var/client/player)
	to_chat(world, "<b>The game is starting!</b>")
