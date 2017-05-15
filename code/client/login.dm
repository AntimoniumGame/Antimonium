/client/New()
	. = ..()
	clients += src
	if(game_state)
		game_state.on_login(src)

/client/Del()
	. = ..()
	clients -= src
