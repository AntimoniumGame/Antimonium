/mob
	var/obj/ui/health/health
	var/obj/ui/controller/target/target_zone
	var/obj/ui/controller/intent/intent
	var/obj/ui/meter/hunger_meter
	var/obj/ui/meter/fatigue_meter
	var/obj/ui/blackout/blindness_overlay
	var/obj/ui/toggle/prone/stand

	var/list/ui_screen = list()
	var/list/ui_images = list()

/mob/Destroy()
	coverage_by_bodypart.Cut()
	for(var/thing in ui_screen)
		var/obj/ui/element = thing
		QDel(element, "mob destroyed")
	ui_screen.Cut()
	ui_images.Cut()
	spawn CheckGameCompletion()
	. = ..()

/mob/proc/CreateUI()

	cooldown_indicator = new(src)
	cooldown_indicator.alpha = 0
	cooldown_indicator.mouse_opacity = 0
	cooldown_indicator.icon = 'icons/images/ui_cooldown.dmi'
	cooldown_indicator.screen_loc = "4,1"
	cooldown_indicator.layer += 0.5

	hunger_meter = new(src, "hunger", _offset = 1)
	fatigue_meter = new(src, "sleep", _offset = 2)
	stand = new(src)

	vision_cone = new(src)
	intent = new(src)
	target_zone = new(src)
	health = new(src)
	new /obj/ui/toggle/inv(src)
	blindness_overlay = new(src)
	blindness_overlay.alpha = 0

/mob/proc/RefreshUI()
	if(client)
		client.screen.Cut()
		client.screen |= ui_screen
		client.images.Cut()
		client.images |= ui_images
		client.OnResize()
	// Light update here probably
	UpdateVisionCone()
