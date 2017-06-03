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

/datum/chat_command/objectives
	command = "objectives"
	usage = "/OBJECTIVES"
	description = "Lists your current objectives, if any."

/datum/chat_command/objectives/Invoke(var/mob/invoker, var/text)
	if(invoker.role && invoker.role.objectives.len)
		var/i = 0
		for(var/thing in invoker.role.objectives)
			var/datum/objective/o = thing
			i++
			invoker.Notify("#[i]. [o.text]")
	else
		invoker.Notify("You do not currently have any objectives.")

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
	usage = "/OOC \<message\>"
	description = "Send a global out of character message."

/datum/chat_command/ooc/Invoke(var/mob/invoker, var/text)
	invoker.DoOocMessage(text)

/datum/chat_command/respawn
	command = "respawn"
	usage = "/RESPAWN"
	description = "Return to the lobby."

/datum/chat_command/respawn/Invoke(var/mob/invoker, var/text)

	if(!istype(invoker, /mob/abstract/ghost))
		invoker.Notify("You must be dead to use this command.")
		return

	invoker.TransferControlTo(new /mob/abstract/new_player())
	QDel(invoker)

/datum/chat_command/keybind
	command = "keybind"
	usage = "/KEYBIND"
	description = "Opens the key rebinding dialogue."

/datum/chat_command/keybind/Invoke(var/mob/invoker, var/text)
	if(invoker.client)
		invoker.client.RebindKey()
