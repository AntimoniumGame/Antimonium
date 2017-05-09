/mob/new_player/do_say(var/message)
	var/list/result = format_string_for_speech(src, message)
	next_speech = world.time + 15
	message = "<b>LOBBY:</b> [result[1]]"
	for(var/mob/new_player/listener in mob_list)
		if(listener.client)
			listener << output(message, "chatoutput")

/mob/new_player/do_emote(var/message)
	next_speech = world.time + 25
	message = format_and_capitalize("<b>LOBBY:</b> <b>\The [src]</b> [sanitize_text(message)]")
	for(var/mob/new_player/listener in mob_list)
		if(listener.client)
			listener << output(message, "chatoutput")