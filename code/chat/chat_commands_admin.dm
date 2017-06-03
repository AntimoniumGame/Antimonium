/datum/chat_command/dsay
	command = "dsay"
	usage = "/DSAY \<message\>"
	description = "Speaks to ghosts/observers."
	required_permissions = PERMISSIONS_MODERATOR

/datum/chat_command/dsay/Invoke(var/mob/invoker, var/text)
	invoker.NotifyDead("[invoker.key] (MOD) says, \"[text]\"")
