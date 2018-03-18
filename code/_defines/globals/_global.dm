var/datum/globals/_glob = new

/datum/globals

	// Begin turf layering.
	// This is a bit easier than trying to maintain numerical vars on the material datums IMO.
	// Position in the list indicates position in layering, lower index means lower in the pile.
	var/list/turf_edge_layers_by_path = list(
		/datum/material/stone/tiles,
		/datum/material/stone,
		/datum/material/stone/cobble,
		/datum/material/stone/brick,
		/datum/material/wood,
		/datum/material/stone/glass/sand,
		/datum/material/dirt,
		/datum/material/dirt/grass,
		/datum/material/dirt/roots,
		/datum/material/cloth,
		/datum/material/cloth/silk
		)
	var/max_turf_edge_layer_value
	var/turf_edge_layer_offset = 0.0001

	// Daemon vars.
	var/datum/daemon/garbage/gc
	var/datum/master_controller/mc

	// Reagent vars
	var/list/all_reagent_reactions = list()
	var/list/reagent_reactions_by_ident = list()

	// Human icon vars.
	var/list/human_hair_types = list()
	var/list/human_bodytypes = list(
		new /datum/human_bodytype/pale,
		new /datum/human_bodytype/dark
		)
	var/list/hair_styles = list(
		"Bald" = 'icons/mobs/hair/_bald.dmi',
		"Tonsure" = 'icons/mobs/hair/tonsure.dmi',
		"Short Hair" = 'icons/mobs/hair/short.dmi',
		"Long Hair" = 'icons/mobs/hair/long.dmi'
	)

	var/list/eye_colours = list(
		PALE_BROWN,
		PALE_GREEN,
		PALE_BLUE,
		PALE_GREY,
		LIGHT_GREY,
		BLUE,
		LIGHT_BLUE,
		DARK_BROWN,
		DARK_GREY,
		DARK_BLUE,
		DARK_GREEN,
		INDIGO,
		DARK_PURPLE,
		DARK_BLUE_GREY,
		BRIGHT_BLUE,
		GREEN_BROWN,
		BROWN_GREEN,
		BROWN_ORANGE,
		BLACK,
		BLUE_GREEN,
		GREY_BLUE,
		NAVY_BLUE
	)

	// Admin vars.
	var/list/config = list()
	var/list/config_numeric = list()
	var/database/admin_db
	var/list/admins = list()
	var/list/admin_permission_datums = list()
	var/list/admin_permissions_by_flag = list()

	// Game state vars.
	var/force_start = FALSE
	var/list/job_datums = list()
	var/list/high_priority_jobs = list()
	var/list/low_priority_jobs = list()
	var/datum/job/default_latejoin_role
	var/game_is_over
	var/datum/game_state/game_state

	// Misc trackers/holders.
	var/list/mob_list = list()
	var/list/living_mob_list = list()
	var/list/dead_mob_list = list()
	var/list/processing_objects = list()
	var/list/clients = list()
	var/list/new_players = list()
	var/list/temperature_sensitive_atoms = list()
	var/list/atoms_to_initialize = list()
	var/list/surgery_steps = list()
	var/list/all_roles = list()
	var/list/burning_atoms = list()
	var/list/ignite_atoms = list()
	var/datum/lobby_music/lobby_music
	var/list/spawnpoints = list()
	var/list/all_outfits = list()
	var/list/vector_list = list()
	var/mob/abstract/viewer/fake_viewer
	var/list/unique_data_by_path = list()
	var/list/burn_sounds = list('sounds/effects/fire1.ogg','sounds/effects/fire2.ogg','sounds/effects/fire3.ogg')
	var/list/all_chat_commands = list()
	var/list/antagonist_datums = list()

/datum/globals/New()

	..()

	// Init nonconstants.
	max_turf_edge_layer_value = turf_edge_layers_by_path.len * turf_edge_layer_offset

	spawn

		// Init global lists.
		InitializeConfig()
		InitializeReagentReactions()
		InitializeAdminPermissions()
		InitializeAdminDatabase()
		InitializeChatCommands()
		InitializeJobs()
		InitializeAntagonists()
		InitializeSurgerySteps()
		InitializeOutfits()

		// Start the game stuff!
		var/lmusic = pick(typesof(/datum/lobby_music)-/datum/lobby_music)
		lobby_music = new lmusic()
		SwitchGameState(/datum/game_state/setup)

	#ifdef TRAVIS_TEST
	world.log << "TRAVIS_TEST defined, this is a testing run and will terminate in ten seconds."
	spawn(100)
		world.log << "Terminating run!"
		sleep(1)
		del(world)
	#endif
