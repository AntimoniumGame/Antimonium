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

/client/verb/force_switch_game_state()

	set name = "Force Game State"
	set category = "Debug"

	var/choice = input("Select a new state.") as null|anything in typesof(/data/game_state)-/data/game_state
	if(!choice) return
	to_chat(src, "Previous state path: [game_state ? game_state.type : "null"]")
	switch_game_state(choice)
	to_chat(src, "Forced state change complete.")
