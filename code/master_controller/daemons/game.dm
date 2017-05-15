/datum/daemon/game
	name = "game"
	delay = 5

/datum/daemon/game/do_work()
	if(game_state)
		game_state.tick()
	check_suspend()

/datum/daemon/game/status()
	return "[game_state.ident] started [game_state.time_created]"