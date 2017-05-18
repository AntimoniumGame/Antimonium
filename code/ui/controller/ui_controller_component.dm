/obj/ui/component
	var/obj/ui/controller/controller

/obj/ui/component/New(var/mob/_owner, var/obj/ui/_controller, var/list/component_args)
	controller = _controller
	screen_loc = controller.screen_loc
	icon = controller.icon
	handle_args(component_args)
	..(_owner)

/obj/ui/component/proc/handle_args(var/list/component_args)
	if(!istype(component_args, /list) || !component_args.len)
		return
	if(component_args["name"])
		icon_state = component_args["name"]
	if(component_args["icon_state"])
		icon_state = component_args["icon_state"]

/obj/ui/component/left_clicked_on(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	. = ..()
	if(. && controller)
		controller.component_left_clicked(src, clicker, slot)

/obj/ui/component/right_clicked_on(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	. = ..()
	if(.)
		controller.component_right_clicked(src, clicker, slot)

/obj/ui/component/middle_clicked_on(var/mob/clicker)
	. = ..()
	if(.)
		controller.component_middle_clicked(src, clicker)
