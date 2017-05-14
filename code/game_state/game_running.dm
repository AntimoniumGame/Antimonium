/data/game_state/running
	ident = GAME_RUNNING

/data/game_state/running/start()
	to_chat(world, "<b>Enjoy the game!</b>")

/data/game_state/running/tick()
	if(check_game_completion())
		to_chat(world, "<b>The game is over!</b>")
		switch_game_state(/data/game_state/over)

/data/game_state/running/proc/check_game_completion()
	return FALSE