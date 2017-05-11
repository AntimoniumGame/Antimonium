var/data/game_state/game_state

/data/game_state
	var/ident
	var/time_created

/data/game_state/New()
	..()
	time_created = world.time

/data/game_state/proc/init()
	start()

/data/game_state/proc/start()
	return

/data/game_state/proc/tick()
	return

/data/game_state/proc/end()
	qdel(src)

/data/game_state/proc/on_login(var/client/player)
	return

/proc/switch_game_state(var/new_state)
	set background = 1
	set waitfor = 0
	if(game_state)
		game_state.end()
	game_state = new new_state()
	game_state.init()
