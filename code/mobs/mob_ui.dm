/mob
	var/obj/ui/health/health
	var/obj/ui/controller/target/target_zone
	var/obj/ui/controller/intent/intent
	var/list/ui_screen = list()
	var/list/ui_images = list()

/mob/Destroy()
	for(var/thing in ui_screen)
		var/obj/ui/element = thing
		QDel(element)
	ui_screen.Cut()
	ui_images.Cut()
	. = ..()

/mob/New()
	..()
	CreateUI()

/mob/Login()
	. = ..()
	RefreshUI()

/mob/proc/CreateUI()
	vision_cone = new(src)
	intent = new(src)
	target_zone = new(src)
	health = new(src)
	new /obj/ui/toggle/inv(src)

/mob/proc/RefreshUI()
	if(client)
		client.screen.Cut()
		client.screen |= ui_screen
		client.images.Cut()
		client.images |= ui_images
		client.OnResize()
	RefreshLighting()
	UpdateVisionCone()
