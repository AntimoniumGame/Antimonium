/world
	fps = 40
	icon_size = 32
	view = 15
	mob = /mob/abstract/new_player
	area = /area/lighting

/world/New()
	. = ..()
	switch_game_state(/data/game_state/setup)
