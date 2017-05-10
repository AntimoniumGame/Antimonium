/mob
	var/obj/ui/doll/target/target_zone
	var/list/ui_screen = list()
	var/list/ui_images = list()

/mob/destroy()
	for(var/thing in ui_screen)
		var/obj/ui/element = thing
		qdel(element)
	ui_screen.Cut()
	ui_images.Cut()
	. = ..()

/mob/New()
	..()
	create_ui()

/mob/Login()
	. = ..()
	refresh_ui()

/mob/proc/create_ui()
	target_zone = new(src)
	ui_screen += target_zone
	ui_screen += target_zone.components

/mob/proc/refresh_ui()
	if(client)
		client.screen.Cut()
		client.screen |= ui_screen
		client.images.Cut()
		client.images |= ui_images
	refresh_lighting()
