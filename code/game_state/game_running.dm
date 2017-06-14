/datum/game_state/running
	ident = GAME_RUNNING

/datum/game_state/running/Start()
	to_chat(world, "<hr><center><h3><b><span class='alert'>Enjoy the game!</span></b></h3></center><hr>")

	// Update objectives, since they were generated prior to game start.
	for(var/thing in antagonist_datums)
		var/datum/antagonist/a = thing
		for(var/other_thing in a.members)
			var/datum/role/r = other_thing
			for(var/third_thing in r.objectives)
				var/datum/objective/o = third_thing
				o.SetObjective()
			r.ShowObjectives()

/datum/game_state/running/Tick()
	if(CheckGameCompletion())
		to_chat(world, "<hr><center><span class='alert'><b><h3>The game is over!</h3></b></span></center><hr>")
		SwitchGameState(/datum/game_state/over)

/datum/game_state/running/proc/CheckGameCompletion()
	return FALSE