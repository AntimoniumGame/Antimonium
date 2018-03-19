/proc/CheckGameCompletion()
	if(_glob.config["end_on_antag_death"])
		for(var/thing in _glob.all_roles)
			var/datum/role/R = thing
			if(istype(R) && length(R.antagonist_roles) && istype(R.mob) && !R.mob.dead)
				_glob.game_is_over = FALSE
				return
		_glob.game_is_over = TRUE

/datum/game_state/running
	ident = GAME_RUNNING

/datum/game_state/running/Start()
	to_chat(world, "<hr><center><h3><b><span class='alert'>Enjoy the game!</span></b></h3></center><hr>")

	// Update objectives, since they were generated prior to game start.
	for(var/thing in _glob.antagonist_datums)
		var/datum/antagonist/a = thing
		for(var/other_thing in a.members)
			var/datum/role/r = other_thing
			for(var/third_thing in r.objectives)
				var/datum/objective/o = third_thing
				o.SetObjective()
			r.ShowObjectives()

/datum/game_state/running/Tick()
	if(_glob.game_is_over)
		to_chat(world, "<hr><center><span class='alert'><b><h3>The game is over!</h3></b></span></center><hr>")
		SwitchGameState(/datum/game_state/over)
