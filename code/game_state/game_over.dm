/datum/game_state/over
	ident = GAME_OVER

/datum/game_state/over/Start()
	to_chat(world, "<b>The game will restart in sixty seconds.</b>")
	sleep(600)
	to_chat(world, "<b>Server rebooting!</b>")
	sleep(5)
	world.Reboot()