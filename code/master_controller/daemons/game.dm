/datum/daemon/game
	name = "game"
	delay = 5

/datum/daemon/game/DoWork()
	if(glob.game_state) glob.game_state.Tick()
	CHECK_SUSPEND

/datum/daemon/game/Status()
	return "[glob.game_state.ident] started [glob.game_state.time_initialized]"