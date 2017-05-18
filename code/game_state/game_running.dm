/datum/game_state/running
	ident = GAME_RUNNING

/datum/game_state/running/start()
	to_chat(world, "<hr><center><h3><b>Enjoy the game!</b></h3></center><hr>")

/datum/game_state/running/tick()
	if(check_game_completion())
		to_chat(world, "<hr><center><b><h3>The game is over!</h3></b></center><hr>")
		switch_game_state(/datum/game_state/over)

/datum/game_state/running/proc/check_game_completion()
	return FALSE