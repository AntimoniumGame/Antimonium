/client/New()
	. = ..()
	clients += src
	onResize()
	if(game_state)
		game_state.on_login(src)

/client/Del()
	. = ..()
	clients -= src
