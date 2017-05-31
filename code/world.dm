/world
	fps = 40
	icon_size = 32
	view = 15
	mob = /mob/abstract/new_player
	area = /area/lighting

/world/New()
	. = ..()
	SwitchGameState(/datum/game_state/setup)
	#ifdef TRAVIS_TEST
	world.log << "TRAVIS_TEST defined, this is a testing run and will terminate in ten seconds."
	spawn(100)
		world.log << "Terminating run!"
		sleep(1)
		del(world)
	#endif
