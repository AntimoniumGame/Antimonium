/data/daemon/game
	name = "game"
	delay = 10

/data/daemon/game/do_work()
	if(game_state)
		game_state.tick()
	check_suspend()

/data/daemon/game/status()
	return "[game_state.ident] started [game_state.time_created]"