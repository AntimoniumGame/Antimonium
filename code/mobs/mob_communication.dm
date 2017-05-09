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

	if(lowertext(copytext(message,1,5)) == "/me ")
		do_emote(copytext(message,5))
	else
		do_say(message)

/mob/proc/do_say(var/message)
	var/list/result = format_string_for_speech(src, message)
	next_speech = world.time + 15
	notify_nearby(result[1])

/mob/proc/do_emote(var/message)
	next_speech = world.time + 25
	message = format_and_capitalize("<b>\The [src]</b> [sanitize_text(message)]")
	notify_nearby(copytext(message,1,120))