/world
	fps = 40
	icon_size = 32
	view = 15
	mob = /mob/abstract/new_player

/world/New()
	. = ..()
	SwitchGameState(/datum/game_state/setup)
