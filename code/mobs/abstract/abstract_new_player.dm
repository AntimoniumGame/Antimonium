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
	if(glob.lobby_music)
		glob.lobby_music.Play(src)
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

/mob/abstract/new_player/Initialize()
	..()
	glob.new_players += src
	spawn(0)
		NullLoc()

/mob/abstract/new_player/Destroy()
	title_image = null
	glob.new_players -= src
	. = ..()

/mob/abstract/new_player/proc/LatejoinGame()

	if(joining)
		return

	switch(glob.game_state.ident)
		if(GAME_SETTING_UP, GAME_STARTING, GAME_LOBBY_WAITING)
			to_chat(src, "<span class='warning'>The game has not started yet!</span>")
			return
		if(GAME_OVER)
			to_chat(src, "<span class='warning'>The game is over!</span>")
			return

	joining = TRUE

	DoFadeout(src, 10)
	sleep(10)

	if(client)
		client.screen -= title_image
		EndLobbyMusic(client)

	var/mob/old_mob = src
	var/mob/new_mob = glob.default_latejoin_role.Equip(src)
	glob.default_latejoin_role.Welcome(new_mob)
	glob.default_latejoin_role.Place(new_mob)
	if(old_mob != new_mob)
		QDel(old_mob, "latejoin replacement")

/mob/abstract/new_player/DoSay(var/message)
	next_speech = world.time + 5
	message = "<b>LOBBY:</b> [FormatStringForSpeech(key, message)]"
	for(var/mob/abstract/new_player/listener in glob.mob_list)
		if(listener.client)
			to_chat(listener, message)

/mob/abstract/new_player/DoEmote(var/message)
	next_speech = world.time + 5
	message = FormatAndCapitalize("<b>LOBBY:</b> <b>\The [src]</b> [SanitizeText(message)]")
	for(var/mob/abstract/new_player/listener in glob.mob_list)
		if(listener.client)
			to_chat(listener, message)

/mob/abstract/new_player/LeftClickOn(var/atom/thing, var/ctrl, var/alt)
	if(istype(thing, /obj/ui))
		thing.LeftClickedOn(src)

/mob/abstract/new_player/OnWindowResize()
	..()
	if(client)
		title_image.Center(client.view_x, client.view_y)