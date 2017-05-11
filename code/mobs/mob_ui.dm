/mob
	var/obj/ui/doll/target/target_zone
	var/obj/ui/intent/intent
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
	if(client)
		client.onResize()

/mob/Login()
	. = ..()
	refresh_ui()

/mob/proc/create_ui()
	intent = new(src)
	ui_screen += intent
	ui_screen += intent.help
	ui_screen += intent.harm

	target_zone = new(src)
	ui_screen += target_zone
	ui_screen += target_zone.components

/mob/proc/refresh_ui()
	if(client)
		client.screen.Cut()
		client.screen |= ui_screen
		client.images.Cut()
		client.images |= ui_images
		client.onResize()
	refresh_lighting()
