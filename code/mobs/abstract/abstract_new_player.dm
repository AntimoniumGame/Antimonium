/mob/abstract/new_player
	var/obj/effect/title/title_image
	var/obj/ui/join_game/join
	var/obj/ui/toggle/options/options
	var/obj/ui/toggle/options/prefs/setup
	var/joining = FALSE
	var/ready = FALSE

/mob/abstract/new_player/Login()
	..()
	NullLoc()
	if(lobby_music)
		lobby_music.Play(src)
	name = key

/mob/abstract/new_player/CreateUI()
	..()
	title_image = new(src)
	setup = new(src)
	join = new(src)
	options = new(src)

/mob/abstract/new_player/RefreshUI()
	. = ..()
	join.UpdateIcon()

/mob/abstract/new_player/New()
	..()
	new_players += src
	spawn(0)
		NullLoc()

/mob/abstract/new_player/Destroy()
	title_image = null
	new_players -= src
	. = ..()

/mob/abstract/new_player/proc/LatejoinGame()

	if(joining)
		return

	switch(game_state.ident)
		if(GAME_SETTING_UP, GAME_STARTING, GAME_LOBBY_WAITING)
			to_chat(src, "The game has not started yet!")
			return
		if(GAME_OVER)
			to_chat(src, "The game is over!")
			return

	joining = TRUE

	DoFadeout(src, 10)
	sleep(10)

	if(client)
		client.screen -= title_image
		EndLobbyMusic(client)

	var/mob/new_mob = default_latejoin_role.Equip(src)
	default_latejoin_role.Welcome(new_mob)
	default_latejoin_role.Place(new_mob)
	QDel(src)

/mob/abstract/new_player/DoSay(var/message)
	next_speech = world.time + 5
	message = "<b>LOBBY:</b> [FormatStringForSpeech(src, message)]"
	for(var/mob/abstract/new_player/listener in mob_list)
		if(listener.client)
			to_chat(listener, message)

/mob/abstract/new_player/DoEmote(var/message)
	next_speech = world.time + 5
	message = FormatAndCapitalize("<b>LOBBY:</b> <b>\The [src]</b> [SanitizeText(message)]")
	for(var/mob/abstract/new_player/listener in mob_list)
		if(listener.client)
			to_chat(listener, message)

/mob/abstract/new_player/LeftClickOn(var/atom/thing, var/ctrl, var/alt)
	if(istype(thing, /obj/ui))
		thing.LeftClickedOn(src)

/mob/abstract/new_player/OnWindowResize()
	..()
	if(client)
		title_image.Center(client.view_x, client.view_y)