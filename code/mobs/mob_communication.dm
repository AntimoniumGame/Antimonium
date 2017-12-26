/mob
	var/next_speech = 0
	var/understand_category = "general"
	var/list/can_understand_speech = list()

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

	if(copytext(message,1,2) == "/")
		var/list/words = splittext(message," ")
		var/prefix = lowertext(copytext(words[1],2))
		words.Cut(1,2)
		if(prefix && all_chat_commands[prefix])
			var/datum/chat_command/command = all_chat_commands[prefix]
			if(command.CanInvoke(src))
				command.Invoke(src, jointext(words, " "))
				return
	DoSay(message)

/mob/proc/DoOocMessage(var/message)
	message = FormatStringForSpeech(key, message)
	next_speech = world.time + 5
	for(var/client/player in clients)
		player.Notify("<b>OOC:</b> [message]")

/mob/proc/DoSay(var/message)
	message = FormatStringForSpeech("\The [name]", message)
	next_speech = world.time + 5

	var/scramble_message
	if(dead)
		NotifyDead(message)
	else
		for(var/mob/M in viewers(world.view, get_turf(src)))
			if(M.CheckCanUnderstand(understand_category))
				M.Notify(message, MESSAGE_AUDIBLE)
			else
				if(!scramble_message)
					scramble_message = "<b>\The [src]</b> [ScrambleSpeech(message)]"
				M.Notify(scramble_message, MESSAGE_AUDIBLE)


/mob/proc/DoEmote(var/message)
	next_speech = world.time + 5
	message = FormatAndCapitalize("<span class='notice'><b>\The [src]</b> [SanitizeText(message)]</span>")
	if(dead)
		NotifyDead(copytext(message,1,120))
	else
		NotifyNearby(copytext(message,1,120))

/mob/proc/NotifyDead(var/message)
	var/list/notified = list()
	for(var/thing in dead_mob_list)
		var/mob/deadite = thing
		if(deadite.client)
			notified += deadite.client
			deadite.Notify("DEAD: [message]")
	for(var/thing in (clients-notified))
		var/client/player = thing
		if(player.CheckAdminPermission(PERMISSIONS_MODERATOR))
			player.Notify("DEAD: [message]")
