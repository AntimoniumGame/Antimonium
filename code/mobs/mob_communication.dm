/mob
	var/next_speech = 0
	var/understand_category = "general"
	var/list/can_understand_speech = list()

/mob/New()
	..()
	can_understand_speech |= understand_category

/mob/proc/ScrambleSpeech(var/message)
	return "gabbles something completely unintelligible."

/mob/proc/CheckCanUnderstand(var/category)
	return (category in can_understand_speech)

/mob/verb/Say(var/message as text)

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
			DoEmote(copytext(message,5))
		if("ooc ")
			DoOocMessage(copytext(message,5))
		else
			DoSay(message)

/mob/proc/DoOocMessage(var/message)
	message = FormatStringForSpeech(src, message)
	next_speech = world.time + 5
	for(var/client/player in clients)
		player.Notify("<b>OOC:</b> [message]")

/mob/proc/DoSay(var/message)
	message = FormatStringForSpeech(src, message)
	next_speech = world.time + 5

	var/scramble_message
	if(dead)
		NotifyDead(message)
	else
		for(var/mob/M in viewers(world.view, get_turf(src)))
			if(M.CheckCanUnderstand(understand_category))
				M.Notify(message)
			else
				if(!scramble_message)
					scramble_message = "<b>\The [src]</b> [ScrambleSpeech(message)]"
				M.Notify(scramble_message)


/mob/proc/DoEmote(var/message)
	next_speech = world.time + 5
	message = FormatAndCapitalize("<b>\The [src]</b> [SanitizeText(message)]")
	if(dead)
		NotifyDead(copytext(message,1,120))
	else
		NotifyNearby(copytext(message,1,120))

/mob/proc/NotifyDead(var/message)
	for(var/thing in dead_mob_list)
		var/mob/deadite = thing
		if(deadite.client)
			deadite.Notify("DEAD: [message]")
