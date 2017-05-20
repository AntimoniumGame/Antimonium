/client/New()
	. = ..()
	clients += src
	if(game_state)
		game_state.OnLogin(src)

/client/Del()
	. = ..()
	clients -= src
