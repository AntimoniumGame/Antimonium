/datum/game_state/setup
	ident = GAME_SETTING_UP

/datum/game_state/setup/Init()

	mc = new()

	InitializeAdminPermissions()
	InitializeAdminDatabase()
	InitializeChatCommands()
	InitializeJobs()

	for(var/thing in atoms_to_initialize)
		var/atom/atom = thing
		atom.Initialize()
	atoms_to_initialize.Cut()
	..()

/datum/game_state/setup/Start()
	SwitchGameState(/datum/game_state/waiting)

/datum/game_state/setup/End()
	to_chat(world, "<b>Game setup complete!</b>")

/datum/game_state/setup/OnLogin(var/client/player)
	to_chat(world, "<b>The game is setting up.</b>")
