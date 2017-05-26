/datum/game_state/over
	ident = GAME_OVER

/datum/game_state/over/Start()
	for(var/thing in antagonist_datums)
		var/datum/antagonist/a = thing
		for(var/other_thing in a.members)
			var/datum/role/r = other_thing
			to_chat(world, "<b>\A [a.role_name] was played by [r.ckey] with these objectives:</b>")
			for(var/line in a.CheckSuccess(r))
				to_chat(world, line)
			to_chat(world, "<br>")
		to_chat(world, "<br>")
	sleep(100)
	to_chat(world, "<b>The game will restart in sixty seconds.</b>")
	sleep(600)
	to_chat(world, "<b>Server rebooting!</b>")
	sleep(5)
	End()

/datum/game_state/over/End()
	world.Reboot()