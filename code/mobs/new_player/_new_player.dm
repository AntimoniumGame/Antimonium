/mob/new_player
	invisibility = INVISIBILITY_MAXIMUM
	var/obj/ui/title/title_image
	var/obj/ui/join_game/join
	var/joining = FALSE

/mob/new_player/create_ui()
	title_image = new(src)
	join = new(src)
	ui_screen += title_image
	ui_screen += join

/mob/new_player/refresh_ui()
	. = ..()
	join.update_icon()

/mob/new_player/New()
	..()
	new_players += src
	spawn(0)
		move_to(null)

/mob/new_player/destroy()
	title_image = null
	new_players -= src
	. = ..()

/mob/new_player/proc/join_game()

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

	do_fadeout(10)
	sleep(10)

	var/mob/human/player_mob = new()
	player_mob.move_to(locate(3,3,1))
	player_mob.name = key
	client.screen -= title_image
	player_mob.key = key
	qdel(src)

