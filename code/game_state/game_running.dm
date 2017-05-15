/datum/game_state/running
	ident = GAME_RUNNING

/datum/game_state/running/start()
	to_chat(world, "<b>Enjoy the game!</b>")

/datum/game_state/running/tick()
	if(check_game_completion())
		to_chat(world, "<b>The game is over!</b>")
		switch_game_state(/datum/game_state/over)

/datum/game_state/running/proc/check_game_completion()
	return FALSE