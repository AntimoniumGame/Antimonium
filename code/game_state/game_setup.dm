/datum/game_state/setup
	ident = GAME_SETTING_UP

/datum/game_state/setup/Init()

	mc = new()

	InitializeConfig()
	InitializeAdminPermissions()
	InitializeAdminDatabase()
	InitializeChatCommands()
	InitializeJobs()
	InitializeAntagonists()

	for(var/thing in atoms_to_initialize)
		var/atom/atom = thing
		atom.Initialize()
	atoms_to_initialize.Cut()
	..()

/datum/game_state/setup/Start()
	SwitchGameState(/datum/game_state/waiting)

/datum/game_state/setup/End()
	to_chat(world, "<h3><b>Game setup complete!</b></h3>")

/datum/game_state/setup/OnLogin(var/client/player)
	to_chat(world, "<h3><b>The game is setting up.</b></h3>")
