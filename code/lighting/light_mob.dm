/mob
	var/obj/plane/master/master_plane
	var/obj/plane/dark/dark_plane

/mob/Login()
	. = ..()

	client.screen.Cut()
	if(!dark_plane)
		dark_plane = new(client)
	else
		client.screen |= dark_plane
	if(!master_plane)
		master_plane = new(client)
	else
		client.screen |= master_plane
