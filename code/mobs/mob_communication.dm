/mob
	var/next_speech = 0

/proc/format_string_for_speech(var/mob/speaker, var/message)

	message = format_and_capitalize(sanitize_text(copytext(message,1,120)))
	var/speak_verb = "says"
	var/overhead_icon = "speech"
	var/ending = copytext(message, length(message))
	if(ending == "!")
		speak_verb = "exclaims"
		overhead_icon = "shout"
	else if(ending == "?")
		speak_verb = "asks"
		overhead_icon = "ask"

	return list("<b>\The [speaker]</b> [speak_verb], \"[message]\"", overhead_icon)

/mob/verb/say(var/message as text)

	set name = "Say"
	set category= "Communication"
	set desc = "Speak your mind! Use '/me' to emote."

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
	var/list/result = format_string_for_speech(src, message)
	next_speech = world.time + 5
	for(var/client/player in clients)
		player.notify("<b>OOC:</b> [result[1]]")

/mob/proc/do_say(var/message)
	var/list/result = format_string_for_speech(src, message)
	next_speech = world.time + 5

	if(dead)
		notify_dead(result[1])
	else
		notify_nearby(result[1])

/mob/proc/do_emote(var/message)
	next_speech = world.time + 5
	message = format_and_capitalize("<b>\The [src]</b> [sanitize_text(message)]")
	if(dead)
		notify_dead(copytext(message,1,120))
	else
		notify_nearby(copytext(message,1,120))

/mob/proc/notify_dead(var/message)
	for(var/mob/deadite in dead_mob_list)
		if(deadite.client)
			deadite.notify("DEAD: [message]")
