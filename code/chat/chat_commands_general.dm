/datum/chat_command/help
	command = "help"
	usage = "/HELP"
	description = "Lists available chat commands."

/datum/chat_command/help/Invoke(var/mob/invoker, var/text)
	invoker.Notify("<b>Chat command list:</b>")
	for(var/chatkey in all_chat_commands)
		var/datum/chat_command/command = all_chat_commands[chatkey]
		if(command.CanInvoke(invoker))
			invoker.Notify("<b>[command.command]</b> - [command.usage] - [command.description]")

/datum/chat_command/emote
	command = "me"
	usage = "/ME \<emote\>"
	description = "Perform an emote."

/datum/chat_command/emote/Invoke(var/mob/invoker, var/text)
	invoker.DoEmote(text)

/datum/chat_command/who
	command = "who"
	usage = "/WHO"
	description = "Lists currently online players."

/datum/chat_command/who/Invoke(var/mob/invoker, var/text)
	invoker.Notify("Players currently online:")
	for(var/client/player in clients)
		if(player.admin_permissions)
			invoker.Notify("[player.key] (<b>[player.admin_permissions.title]</b>)")
		else
			invoker.Notify("[player.key]")
	invoker.Notify("Total players: [clients.len].")

/datum/chat_command/ooc
	command = "ooc"
	usage = "OOC \<message\>"
	description = "Send a global out of character message."

/datum/chat_command/ooc/Invoke(var/mob/invoker, var/text)
	invoker.DoOocMessage(text)
