var/datum/lobby_music/lobby_music

/client
	var/sound/playing_lobby_music

/proc/EndLobbyMusic(var/client/listener)
	set waitfor = 0
	set background = 1

	while(listener && listener.playing_lobby_music)
		if(listener.playing_lobby_music.volume > 0)
			listener.playing_lobby_music.volume = max(0, listener.playing_lobby_music.volume - 1)
			listener.playing_lobby_music.status = SOUND_UPDATE
			listener << listener.playing_lobby_music
			sleep(1)
			continue
		listener << sound(channel = SOUND_CHANNEL_LOBBY)
		listener.playing_lobby_music = null

/world/New()
	. = ..()
	var/lmusic = pick(typesof(/datum/lobby_music)-/datum/lobby_music)
	lobby_music = new lmusic()

/datum/lobby_music
	var/song_file
	var/name
	var/author
	var/url
	var/license
	var/license_url

/datum/lobby_music/proc/Play(var/mob/listener)

	set waitfor = 0
	set background = 1

	if(!song_file || !listener.client) return
	listener.Notify("<span class='notice'><b>Now playing:</b> <span class='alert'><a href='[url]'>[name]</a></span> by <span class='alert'><b>[author]</b></span> ([license ? "<a href='[license_url]'>[license]</a>": "no license supplied"])</span>")
	listener.client.playing_lobby_music = sound(song_file, repeat = 1, channel = SOUND_CHANNEL_LOBBY, volume = 85)
	PlayClientSound(listener.client, sound = listener.client.playing_lobby_music, volume = 85, frequency = -1)
