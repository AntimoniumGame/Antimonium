/data/game_state/waiting
	ident = GAME_LOBBY_WAITING
	var/roundstart_delay = 100 //1800
/data/game_state/waiting/start()
	to_chat(world, "<b>Welcome to the lobby. The game will begin shortly.</b>")

/data/game_state/waiting/tick()
	if(force_start || world.time > (time_created + roundstart_delay))
		switch_game_state(/data/game_state/starting)

/data/game_state/waiting/on_login(var/client/player)
	to_chat(world, "<b>The game will begin in a few minutes!</b>")
