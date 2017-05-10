// Placeholder.

/obj/ui/join_game
	name = "Join Game"
	icon = 'icons/images/ui_title_buttons.dmi'

/obj/ui/join_game/center(var/view_x, var/view_y)
	screen_loc = "[round(view_x/2)],[round(view_y/2)]-4"

/obj/ui/join_game/left_clicked_on(var/mob/clicker)
	. = ..()
	if(.)
		var/mob/new_player/player = clicker
		if(istype(player))
			player.join_game()

/obj/ui/join_game/right_clicked_on(var/mob/clicker)
	. = ..()
	if(.)
		var/mob/new_player/player = clicker
		if(istype(player))
			player.join_game()

/obj/ui/join_game/middle_clicked_on(var/mob/clicker)
	. = ..()
	if(.)
		var/mob/new_player/player = clicker
		if(istype(player))
			player.join_game()

/obj/ui/title
	name = "Antimonium"
	icon = 'icons/images/title_image.dmi'
	screen_loc = "CENTER, CENTER"

/obj/ui/title/center(var/view_x, var/view_y)
	screen_loc = "[round(view_x/2)-3],[round(view_y/2)-2]"

/obj/ui/title/left_clicked_on(var/mob/clicker)
	return FALSE

/obj/ui/title/right_clicked_on(var/mob/clicker)
	return FALSE

/obj/ui/title/middle_clicked_on(var/mob/clicker)
	return FALSE