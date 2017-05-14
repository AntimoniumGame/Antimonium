var/data/lobby_music/lobby_music

/client
	var/sound/playing_lobby_music

/proc/end_lobby_music(var/client/listener)
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
	var/lmusic = pick(typesof(/data/lobby_music))
	lobby_music = new lmusic()

/data/lobby_music
	var/song_file = 'sounds/music/Chris_Zabriskie_-_09_-_Cylinder_Nine.ogg'
	var/name = "Cylinder 9"
	var/author = "Chris Zabriskie"
	var/url = "http://freemusicarchive.org/music/Chris_Zabriskie/2014010103336111/Chris_Zabriskie_-_Cylinders_-_09_-_Cylinder_Nine"
	var/license
	var/license_url

/data/lobby_music/proc/play(var/mob/listener)

	set waitfor = 0
	set background = 1

	if(!song_file || !listener.client) return
	listener.notify("<b>Now playing:</b> <a href='[url]'>[name]</a> by <b>[author]</b> ([license ? "<a href='[license_url]'>[license]</a>": "no license supplied"])")
	listener.client.playing_lobby_music = sound(song_file, repeat = 1, channel = SOUND_CHANNEL_LOBBY, volume = 85)
	play_client_sound(listener.client, sound = listener.client.playing_lobby_music, volume = 85, frequency = -1)
