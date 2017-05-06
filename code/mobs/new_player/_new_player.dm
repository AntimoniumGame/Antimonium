/mob/new_player
	invisibility = INVISIBILITY_MAXIMUM

/mob/new_player/New()
	..()
	spawn(0)
		loc = null

/mob/new_player/Login()
	. = ..()
	client.screen |= get_title_image()

/mob/new_player/verb/join_game()

	set name = "Join Game"
	set category = "Commands"

	var/mob/player_mob = new(locate(1,1))
	player_mob.key = key
	del(src)
