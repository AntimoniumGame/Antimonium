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
		move_to(null)

/mob/new_player/Login()
	. = ..()
	client.screen += get_title_image()

/mob/new_player/verb/join_game()

	set name = "Join Game"
	set category = "Commands"

	verbs -= /mob/new_player/verb/join_game

	do_fadeout(10)
	sleep(10)

	var/mob/human/player_mob = new()
	player_mob.move_to(locate(5,5,1))
	player_mob.name = key
	client.screen -= get_title_image()
	client.eye = player_mob

	player_mob.key = key

	qdel(src)

/mob/new_player/create_ui()
	return
