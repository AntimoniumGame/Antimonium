
/obj/ui/join_game
	name = "Join Game"
	icon = 'icons/images/ui_title_buttons.dmi'
	icon_state = "ready_on"
	maptext_y = 16
	maptext_x = 16
	var/game_start_time = 0

/obj/ui/join_game/Center(var/view_x, var/view_y)
	screen_loc = "[round(view_x/2)]+2,[round(view_y/2)-4]"

/obj/ui/join_game/UpdateIcon()
	if(!_glob.game_state || _glob.game_state.ident != GAME_RUNNING)
		var/mob/abstract/new_player/player = owner
		if(player.ready)
			icon_state = "ready_off"
		else
			icon_state = "ready_on"

		if(game_start_time - world.time >= 0)
			maptext = "<center><b>[Ticks2Time(game_start_time - world.time)]<center></b>"
		else
			maptext = null
	else
		icon_state = "join_off"
		maptext = null

/obj/ui/join_game/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	. = ..()
	if(.) TryLatejoinGame(clicker)

/obj/ui/join_game/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	. = ..()
	if(.) TryLatejoinGame(clicker)

/obj/ui/join_game/proc/TryLatejoinGame(var/mob/clicker)
	var/mob/abstract/new_player/player = clicker
	if(istype(player))
		if(player.client)
			PlayClientSound(player.client, null, 'sounds/effects/click1.ogg', 100, -1)

		if(!_glob.game_state || _glob.game_state.ident != GAME_RUNNING)
			player.ready = !player.ready
			UpdateIcon()
		else
			icon_state = "join_on"
			player.LatejoinGame()
