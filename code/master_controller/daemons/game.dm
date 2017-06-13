/datum/daemon/game
	name = "game"
	delay = 5

/datum/daemon/game/DoWork()
	if(game_state)
		game_state.Tick()
	CHECK_SUSPEND

/datum/daemon/game/Status()
	return "[game_state.ident] started [game_state.time_initialized]"