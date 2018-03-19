/datum/game_state
	var/ident
	var/time_initialized

/datum/game_state/proc/Init()
	time_initialized = world.time
	Start()

/datum/game_state/proc/Start()
	return

/datum/game_state/proc/Tick()
	return

/datum/game_state/proc/End()
	QDel(src, "game state ended")

/datum/game_state/proc/OnLogin(var/client/player)
	return

/proc/SwitchGameState(var/new_state)
	set background = 1
	set waitfor = 0
	if(_glob.game_state)
		_glob.game_state.End()
	_glob.game_state = new new_state()
	_glob.game_state.Init()
