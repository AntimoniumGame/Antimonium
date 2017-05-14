/data/game_state/waiting
	ident = GAME_LOBBY_WAITING
	var/roundstart_delay = 100 //1800

/data/game_state/waiting/start()
	to_chat(world, "<b>Welcome to the lobby. The game will begin shortly.</b>")
	tick()

/data/game_state/waiting/tick()
	if(force_start || world.time > (time_created + roundstart_delay))
		switch_game_state(/data/game_state/starting)
	else
		for(var/thing in new_players)
			var/mob/abstract/new_player/player = thing
			player.join.game_start_time = time_created + roundstart_delay
			player.join.update_icon()

/data/game_state/waiting/end()
	spawn()
		for(var/thing in new_players)
			var/mob/abstract/new_player/player = thing
			player.join.update_icon()

/data/game_state/waiting/on_login(var/client/player)
	to_chat(world, "<b>The game will begin in a few minutes!</b>")
