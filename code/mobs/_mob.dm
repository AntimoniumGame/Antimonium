/mob
	icon = 'icons/mobs/mob.dmi'

/mob/Login()
	. = ..()
	if(client)
		client.screen.Cut()
		update_client_screen()

/mob/proc/update_client_screen()
	return
