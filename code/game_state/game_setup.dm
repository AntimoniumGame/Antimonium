/datum/game_state/setup
	ident = GAME_SETTING_UP

/datum/game_state/setup/Init()
	spawn()
		mc = new()
		InitializeAdminPermissions()
		InitializeAdminDatabase()
		InitializeJobs()
	..()

/datum/game_state/setup/Start()
	SwitchGameState(/datum/game_state/waiting)

/datum/game_state/setup/End()
	to_chat(world, "<b>Game setup complete!</b>")

/datum/game_state/setup/OnLogin(var/client/player)
	to_chat(world, "<b>The game is setting up.</b>")
