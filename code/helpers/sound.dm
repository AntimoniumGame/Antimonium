/proc/play_global_sound(var/sound, var/volume, var/frequency)

	if(!sound)
		return

	if(isnull(frequency))
		frequency = rand(32000, 55000)

	for(var/thing in clients)
		var/client/player = thing
		if(!player.mob)
			continue
		player.mob.receive_sound(sound, volume, frequency, 0)

/proc/play_client_sound(var/client/player, var/atom/origin, var/sound, var/volume, var/frequency)

	if(!sound || !player.mob)
		return

	if(isnull(frequency))
		frequency = rand(32000, 55000)

	player.mob.receive_sound(sound, volume, frequency, 0, (origin ? get_turf(origin) : null))

/proc/play_local_sound(var/atom/origin, var/sound, var/volume, var/frequency)

	if(!sound || !origin)
		return

	if(!istype(origin))
		origin = get_turf(origin)
		if(!istype(origin))
			return

	if(isnull(frequency))
		frequency = rand(32000, 55000)

	for(var/thing in clients)
		var/client/player = thing
		if(!istype(player) || !player.mob)
			continue
		var/turf/mob_turf = get_turf(player.mob)
		if(!istype(mob_turf))
			continue
		var/distance = get_dist(mob_turf, origin)
		if(distance <= (world.view * 2))
			player.mob.receive_sound(sound, volume, frequency, distance, origin)

/mob/proc/receive_sound(var/sound, var/volume, var/frequency, var/distance, var/turf/origin)

	if(volume <= 0)
		return

	var/sound/playing = sound
	if(!istype(playing))
		playing = sound(playing)
	if(!istype(playing))
		return

	// Distance falloff.
	playing.volume = volume
	if(distance && distance > 0)
		playing.volume -= max(distance-world.view, 0)*2
		if(playing.volume <= 0)
			return

	if(frequency && frequency != -1)
		playing.frequency = frequency

	playing.volume = volume
	if(isnull(playing.channel))
		playing.channel = SOUND_CHANNEL_DEFAULT
	playing.wait = 0

	var/turf/current_turf = get_turf(src)
	if(istype(current_turf))
		playing.environment = current_turf.get_sound_environment()
		// 3D sound.
		if(istype(origin))
			playing.x = origin.x - current_turf.x
			playing.z = origin.y - current_turf.y
			playing.y = 1 // No idea why y for sound == z for the map.
	src << playing

/turf/proc/get_sound_environment()
	return -1

var/mob/human/next_footstep = 0
/mob/human/Move()
	. = ..()
	if(. && world.time > next_footstep)
		var/turf/current_turf = get_turf(src)
		if(istype(current_turf))
			next_footstep = world.time + get_move_delay()*2.5
			play_local_sound(src, current_turf.get_footstep_sound(src), 5)

/turf/proc/get_footstep_sound(var/mob/walker)
	return 'sounds/effects/footstep1.wav'
