/mob
	var/obj/ui/health/health
	var/obj/ui/controller/target/target_zone
	var/obj/ui/controller/intent/intent
	var/obj/ui/meter/hunger_meter
	var/obj/ui/meter/fatigue_meter

	var/list/ui_screen = list()
	var/list/ui_images = list()

/mob/Destroy()
	for(var/thing in ui_screen)
		var/obj/ui/element = thing
		QDel(element)
	ui_screen.Cut()
	ui_images.Cut()
	. = ..()

/mob/proc/CreateUI()
	hunger_meter = new(src, "hunger", _offset = 1)
	fatigue_meter = new(src, "sleep", _offset = 2)

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
	// Light update here probably
	UpdateVisionCone()
