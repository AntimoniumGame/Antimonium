/datum/game_state/waiting
	ident = GAME_LOBBY_WAITING
	var/roundstart_delay = 1800
	var/force_start

/datum/game_state/waiting/Start()
	to_chat(world, "<b>Welcome to the lobby. The game will begin shortly.</b>")
	Tick()

/datum/game_state/waiting/Tick()
	if(force_start || world.time > (time_created + roundstart_delay))
		SwitchGameState(/datum/game_state/starting)
	else
		for(var/thing in new_players)
			var/mob/abstract/new_player/player = thing
			player.join.game_start_time = time_created + roundstart_delay
			player.join.UpdateIcon()

/datum/game_state/waiting/End()
	spawn()
		for(var/thing in new_players)
			var/mob/abstract/new_player/player = thing
			player.join.UpdateIcon()

/datum/game_state/waiting/OnLogin(var/client/player)
	to_chat(world, "<b>The game will begin in a few minutes!</b>")
