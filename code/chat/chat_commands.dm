/proc/InitializeChatCommands()
	for(var/ccommand in (typesof(/datum/chat_command)-/datum/chat_command))
		var/datum/chat_command/c = new ccommand()
		glob.all_chat_commands[c.command] = c

/datum/chat_command
	var/command
	var/usage
	var/description
	var/required_permissions = 0

/datum/chat_command/proc/CanInvoke(var/mob/invoker)
	if(!invoker.client)
		return FALSE
	if(required_permissions && !invoker.client.CheckAdminPermission(required_permissions))
		return FALSE
	return TRUE

/datum/chat_command/proc/Invoke(var/mob/invoker, var/text)
	return
