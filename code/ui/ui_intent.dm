/obj/ui/intent
	icon = 'icons/images/ui_intent.dmi'
	icon_state = "underlay"
	screen_loc = "8,1"

	var/selecting = INTENT_HELP
	var/obj/ui/intent_button/help
	var/obj/ui/intent_button/harm

/obj/ui/intent/New(var/mob/_owner, var/_intent)
	..(_owner)
	help = new(owner, INTENT_HELP, src)
	harm = new(owner, INTENT_HARM, src)
	set_selecting(selecting)

/obj/ui/intent/proc/set_selecting(var/intent)
	selecting = intent
	if(selecting == INTENT_HELP)
		help.alpha = 255
		harm.alpha = 20
	else
		help.alpha = 20
		harm.alpha = 255

/obj/ui/intent_button
	icon_state = "underlay"
	var/obj/ui/intent/controller
	var/intent

/obj/ui/intent_button/New(var/mob/_owner, var/_intent, var/obj/ui/intent/_controller)
	..(_owner)
	controller = _controller
	screen_loc = controller.screen_loc
	intent = _intent
	icon = controller.icon
	icon_state = intent
	name = "[capitalize(intent)]"

/obj/ui/intent_button/left_clicked_on(var/mob/clicker)
	. = ..()
	if(.)
		controller.set_selecting(intent)

/obj/ui/intent_button/right_clicked_on(var/mob/clicker)
	. = ..()
	if(.)
		controller.set_selecting(intent)

/obj/ui/intent_button/middle_clicked_on(var/mob/clicker)
	. = ..()
	if(.)
		controller.set_selecting(intent)
