/mob/new_player
	invisibility = INVISIBILITY_MAXIMUM
	var/obj/blackout

/mob/new_player/destroy()
	qdel(blackout)
	blackout = null
	. = ..()

/mob/new_player/New()
	..()
	spawn(0)
		loc = null

/mob/new_player/Login()
	. = ..()
	client.screen += get_title_image()

/mob/new_player/verb/join_game()

	set name = "Join Game"
	set category = "Commands"

	verbs -= /mob/new_player/verb/join_game
	animate(blackout, alpha = 255, time = 10)

	sleep(10)

	var/mob/player_mob = new()
	player_mob.move_to(locate(1,1,1))
	player_mob.name = key
	client.screen -= get_title_image()
	client.screen -= blackout
	player_mob.ckey = ckey
	qdel(src)
