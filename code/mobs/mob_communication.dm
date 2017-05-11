/mob
	var/next_speech = 0

/proc/format_string_for_speech(var/mob/speaker, var/message)
	message = format_and_capitalize(sanitize_text(copytext(message,1,120)))
	var/speak_verb = "says"
	var/ending = copytext(message, length(message))
	if(ending == "!")
		speak_verb = "exclaims"
	else if(ending == "?")
		speak_verb = "asks"
	return "<b>\The [speaker]</b> [speak_verb], \"[message]\""

/mob/verb/say(var/message as text)

	set name = "Say"
	set category= "Communication"
	set desc = "Speak your mind! Use '/me' to emote and 'ooc' to speak on the global OOC channel."

	if(world.time < next_speech)
		return

	if(!message)
		message = input("What would you like to say? Use '/me' to emote. ") as text|null

	if(!message)
		return

	if(world.time < next_speech)
		return

	var/prefix = lowertext(copytext(message,1,5))
	switch(prefix)
		if("/me ")
			do_emote(copytext(message,5))
		if("ooc ")
			do_ooc_message(copytext(message,5))
		else
			do_say(message)

/mob/proc/do_ooc_message(var/message)
	message = format_string_for_speech(src, message)
	next_speech = world.time + 5
	for(var/client/player in clients)
		player.notify("<b>OOC:</b> [message]")

/mob/proc/do_say(var/message)
	message = format_string_for_speech(src, message)
	next_speech = world.time + 5

	if(dead)
		notify_dead(message)
	else
		notify_nearby(message)

/mob/proc/do_emote(var/message)
	next_speech = world.time + 5
	message = format_and_capitalize("<b>\The [src]</b> [sanitize_text(message)]")
	if(dead)
		notify_dead(copytext(message,1,120))
	else
		notify_nearby(copytext(message,1,120))

/mob/proc/notify_dead(var/message)
	for(var/thing in dead_mob_list)
		var/mob/deadite = thing
		if(deadite.client)
			deadite.notify("DEAD: [message]")
