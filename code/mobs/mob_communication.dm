/mob
	var/next_speech = 0
	var/understand_category = "general"
	var/list/can_understand_speech = list()

/mob/New()
	..()
	can_understand_speech |= understand_category

/mob/proc/scramble_speech(var/message)
	return "gabbles something completely unintelligible."

/mob/proc/check_can_understand(var/category)
	return (category in can_understand_speech)

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

	var/scramble_message
	if(dead)
		notify_dead(message)
	else
		for(var/mob/M in viewers(world.view, get_turf(src)))
			if(M.check_can_understand(understand_category))
				M.notify(message)
			else
				if(!scramble_message)
					scramble_message = "<b>\The [src]</b> [scramble_speech(message)]"
				M.notify(scramble_message)


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
