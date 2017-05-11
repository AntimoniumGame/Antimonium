/world
	fps = 60
	icon_size = 32
	view = 15
	mob = /mob/new_player

/world/New()
	. = ..()
	switch_game_state(/data/game_state/setup)
