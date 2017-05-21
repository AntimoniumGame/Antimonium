/obj/ui/component
	var/obj/ui/controller/controller

/obj/ui/component/New(var/mob/_owner, var/obj/ui/_controller, var/list/component_args)
	controller = _controller
	screen_loc = controller.screen_loc
	icon = controller.icon
	HandleArgs(component_args)
	..(_owner)

/obj/ui/component/proc/HandleArgs(var/list/component_args)
	if(!istype(component_args, /list) || !component_args.len)
		return
	if(component_args["name"])
		icon_state = component_args["name"]
	if(component_args["icon_state"])
		icon_state = component_args["icon_state"]

/obj/ui/component/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	. = ..()
	if(. && controller)
		controller.ComponentLeftClicked(src, clicker, slot)

/obj/ui/component/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	. = ..()
	if(.)
		controller.ComponentRightClicked(src, clicker, slot)

/obj/ui/component/MiddleClickedOn(var/mob/clicker)
	. = ..()
	if(.)
		controller.ComponentMiddleClicked(src, clicker)
