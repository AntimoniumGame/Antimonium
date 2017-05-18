
/obj/ui/join_game
	name = "Join Game"
	icon = 'icons/images/ui_title_buttons.dmi'
	icon_state = "join_on"
	maptext_y = -6
	maptext_x = 16
	var/game_start_time = 0

/obj/ui/join_game/center(var/view_x, var/view_y)
	screen_loc = "[round(view_x/2)]+2,[round(view_y/2)-4]"

/obj/ui/join_game/update_icon()
	if(!game_state || game_state.ident != GAME_RUNNING)
		icon_state = "join_on"
		if(game_start_time - world.time >= 0)
			maptext = "<center><b>[ticks2time(game_start_time - world.time)]<center></b>"
		else
			maptext = null
	else
		icon_state = "join_off"
		maptext = null

/obj/ui/join_game/left_clicked_on(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	. = ..()
	if(.) try_join_game(clicker)

/obj/ui/join_game/right_clicked_on(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	. = ..()
	if(.) try_join_game(clicker)

/obj/ui/join_game/proc/try_join_game(var/mob/clicker)
	var/mob/abstract/new_player/player = clicker
	if(istype(player))
		if(player.client)
			play_client_sound(player.client, null, 'sounds/effects/click1.wav', 100, -1)
		icon_state = "join_on"
		player.join_game()
