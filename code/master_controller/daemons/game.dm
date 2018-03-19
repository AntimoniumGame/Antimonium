/datum/daemon/game
	name = "game"
	delay = 5

/datum/daemon/game/DoWork()
	if(_glob.game_state) _glob.game_state.Tick()
	CHECK_SUSPEND

/datum/daemon/game/Status()
	return "[_glob.game_state.ident] started [_glob.game_state.time_initialized]"