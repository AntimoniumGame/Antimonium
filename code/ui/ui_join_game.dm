
/obj/ui/join_game
	name = "Join Game"
	icon = 'icons/images/ui_title_buttons.dmi'
	icon_state = "join_on"
	maptext_y = -6
	maptext_x = 16
	var/game_start_time = 0

/obj/ui/join_game/Center(var/view_x, var/view_y)
	screen_loc = "[round(view_x/2)]+2,[round(view_y/2)-4]"

/obj/ui/join_game/UpdateIcon()
	if(!game_state || game_state.ident != GAME_RUNNING)
		icon_state = "join_on"
		if(game_start_time - world.time >= 0)
			maptext = "<center><b>[Ticks2Time(game_start_time - world.time)]<center></b>"
		else
			maptext = null
	else
		icon_state = "join_off"
		maptext = null

/obj/ui/join_game/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	. = ..()
	if(.) TryJoinGame(clicker)

/obj/ui/join_game/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	. = ..()
	if(.) TryJoinGame(clicker)

/obj/ui/join_game/proc/TryJoinGame(var/mob/clicker)
	var/mob/abstract/new_player/player = clicker
	if(istype(player))
		if(player.client)
			PlayClientSound(player.client, null, 'sounds/effects/click1.wav', 100, -1)
		icon_state = "join_on"
		player.JoinGame()
