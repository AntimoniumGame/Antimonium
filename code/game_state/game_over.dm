/datum/game_state/over
	ident = GAME_OVER

/datum/game_state/over/Start()
	for(var/thing in _glob.antagonist_datums)
		var/datum/antagonist/a = thing

		if(!istype(a) || !istype(a.members, /list) || !a.members.len)
			continue

		if(a.group_objectives && a.group_antagonist)
			to_chat(world, "<span class='notice'><b>\The <span class='alert'>[a.role_name_plural]</span> were played by:<br>")
			for(var/other_thing in a.members)
				var/datum/role/r = other_thing
				to_chat(world, "<span class='alert'>[r.ckey]</span> <span class='notice'>as</span> <span class='alert'>[r.GetOriginalName()]</span><br>")
			to_chat(world, "<br><span class='notice'>They had the following objectives:</span>")
			for(var/line in a.CheckSuccess())
				to_chat(world, "<span class='notice'>[line]</span>")
		else
			for(var/other_thing in a.members)
				var/datum/role/r = other_thing
				to_chat(world, "<span class='notice'><b>\A <span class='alert'>[a.role_name]</span> (<span class='alert'>[r.ckey]</span>) had these objectives:</b></span>")
				for(var/line in a.CheckSuccess(r))
					to_chat(world, "<span class='notice'>[line]</span>")
		to_chat(world, "<br>")
	sleep(100)
	to_chat(world, "<span class='alert'><b>The game will restart in sixty seconds.</b>")
	sleep(600)
	to_chat(world, "<span class='alert'><b>Server rebooting!</b>")
	sleep(5)
	End()

/datum/game_state/over/End()
	world.Reboot()