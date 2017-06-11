/obj/ui/controller/intent
	icon = 'icons/images/ui_intent.dmi'
	icon_state = "underlay"
	screen_loc = "8,1"

	var/selecting = INTENT_HELP
	var/obj/ui/component/intent/help
	var/obj/ui/component/intent/harm

/obj/ui/controller/intent/New(var/mob/_owner, var/_intent)
	..(_owner)
	help = new(owner, src, list("name" = "Help", "icon_state" = INTENT_HELP))
	harm = new(owner, src, list("name" = "Harm", "icon_state" = INTENT_HARM))
	GetInputFrom(help)

/obj/ui/controller/intent/GetInputFrom(var/obj/ui/component/component)
	if(component == help)
		selecting = INTENT_HELP
		help.alpha = 255
		harm.alpha = 20
	else
		selecting = INTENT_HARM
		help.alpha = 20
		harm.alpha = 255

/obj/ui/controller/intent/proc/SwapIntent()
	if(selecting == INTENT_HELP)
		GetInputFrom(harm)
	else
		GetInputFrom(help)

/obj/ui/component/intent/UpdateIcon()
	return
