var/datum/game_state/game_state

/datum/game_state
	var/ident
	var/time_created

/datum/game_state/New()
	..()
	time_created = world.time

/datum/game_state/proc/init()
	start()

/datum/game_state/proc/start()
	return

/datum/game_state/proc/tick()
	return

/datum/game_state/proc/end()
	qdel(src)

/datum/game_state/proc/on_login(var/client/player)
	return

/proc/switch_game_state(var/new_state)
	set background = 1
	set waitfor = 0
	if(game_state)
		game_state.end()
	game_state = new new_state()
	game_state.init()
