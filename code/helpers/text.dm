// todo
/proc/trim_spaces(var/message = "")
	if(!message || message == "")
		return ""
	return message

/proc/sanitize_text(var/message = "", var/max_length = 200)

	// Trim down to size.
	message = copytext(message,1,max_length)

	// Remove HTML tags.
	message = replacetext(message, "<", "")
	message = replacetext(message, ">", "")

	// Remove trailing spaces.
	message = trim_spaces(message)
	return message

/proc/capitalize(var/message = "")
	return "[uppertext(copytext(message,1,2))][copytext(message,2)]"

/proc/format_and_capitalize(var/message = "")
	message = capitalize(message)
	if(!(copytext(message, length(message)) in list("!","?",".")))
		message += "."
	return message

/proc/ticks2time(var/ticks)
	var/seconds = round((ticks%600)/10)
	return "[round(ticks/600)]:[seconds >= 10 ? seconds : "0[seconds]"]"


/proc/format_string_for_speech(var/mob/speaker, var/message)
	message = format_and_capitalize(sanitize_text(copytext(message,1,120)))
	var/speak_verb = "says"
	var/ending = copytext(message, length(message))
	if(ending == "!")
		speak_verb = "exclaims"
	else if(ending == "?")
		speak_verb = "asks"
	return "<b>\The [speaker]</b> [speak_verb], \"[message]\""
