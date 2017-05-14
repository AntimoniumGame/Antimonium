/mob/abstract/new_player
	var/obj/ui/title/title_image
	var/obj/ui/join_game/join
	var/obj/ui/setup_prefs/setup
	var/obj/ui/options/options
	var/joining = FALSE

/mob/abstract/new_player/Login()
	..()
	if(lobby_music)
		lobby_music.play(src)

/mob/abstract/new_player/create_ui()

	title_image = new(src)
	setup = new(src)
	join = new(src)
	options = new(src)

	ui_screen += setup
	ui_screen += title_image
	ui_screen += join
	ui_screen += options

/mob/abstract/new_player/refresh_ui()
	. = ..()
	join.update_icon()

/mob/abstract/new_player/New()
	..()
	new_players += src
	spawn(0)
		null_loc()

/mob/abstract/new_player/destroy()
	title_image = null
	new_players -= src
	. = ..()

/mob/abstract/new_player/proc/join_game()

	if(joining)
		return

	switch(game_state.ident)
		if(GAME_SETTING_UP, GAME_STARTING, GAME_LOBBY_WAITING)
			to_chat(src, "The game has not started yet!")
			return
		if(GAME_OVER)
			to_chat(src, "The game is over!")
			return

	join.icon_state = "join_off"
	joining = TRUE

	do_fadeout(src, 10)
	sleep(10)

	if(client)
		client.screen -= title_image
		end_lobby_music(client)

	var/mob/human/player_mob = new()
	player_mob.force_move(locate(3,3,1))
	player_mob.name = key
	player_mob.key = key
	qdel(src)

/mob/abstract/new_player/do_say(var/message)
	var/list/result = format_string_for_speech(src, message)
	next_speech = world.time + 15
	message = "<b>LOBBY:</b> [result[1]]"
	for(var/mob/abstract/new_player/listener in mob_list)
		if(listener.client)
			to_chat(listener, message)

/mob/abstract/new_player/do_emote(var/message)
	next_speech = world.time + 25
	message = format_and_capitalize("<b>LOBBY:</b> <b>\The [src]</b> [sanitize_text(message)]")
	for(var/mob/abstract/new_player/listener in mob_list)
		if(listener.client)
			to_chat(listener, message)

/mob/abstract/left_click_on(var/atom/thing, var/ctrl, var/alt)
	thing.left_clicked_on(src)