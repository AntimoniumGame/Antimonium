/obj/ui/doll/target
	name = "Target Zone"
	screen_loc = "7,1"
	icon_state = "underlay_target"

	var/selecting = BP_CHEST
	var/list/components = list()

/obj/ui/doll/target/update_icon()
	for(var/thing in components)
		var/obj/ui/target_doll_component/component = thing
		component.update_icon()

/obj/ui/doll/target/New(var/mob/_owner)
	components += new /obj/ui/target_doll_component(_owner, BP_CHEST,      "upper body", src)
	components += new /obj/ui/target_doll_component(_owner, BP_GROIN,      "lower body", src)
	components += new /obj/ui/target_doll_component(_owner, BP_HEAD,       "head",       src)
	components += new /obj/ui/target_doll_component(_owner, BP_LEFT_ARM,   "left arm",   src)
	components += new /obj/ui/target_doll_component(_owner, BP_LEFT_LEG,   "left leg",   src)
	components += new /obj/ui/target_doll_component(_owner, BP_LEFT_HAND,  "left hand",  src)
	components += new /obj/ui/target_doll_component(_owner, BP_LEFT_FOOT,  "left foot",  src)
	components += new /obj/ui/target_doll_component(_owner, BP_RIGHT_ARM,  "right arm",  src)
	components += new /obj/ui/target_doll_component(_owner, BP_RIGHT_LEG,  "right leg",  src)
	components += new /obj/ui/target_doll_component(_owner, BP_RIGHT_HAND, "right hand", src)
	components += new /obj/ui/target_doll_component(_owner, BP_RIGHT_FOOT, "right foot", src)
	..(_owner)

/obj/ui/doll/target/proc/set_selecting(var/_selecting)
	selecting = _selecting
	update_icon()

/obj/ui/target_doll_component
	var/limb_id
	var/obj/ui/doll/target/controller
	alpha = 128

/obj/ui/target_doll_component/New(var/mob/_owner, var/_limb_id, var/_name, var/obj/ui/doll/target/_controller)
	name = _name
	limb_id = _limb_id
	controller = _controller
	icon = controller.icon
	icon_state = "[limb_id]"
	screen_loc = controller.screen_loc
	..(_owner)

/obj/ui/target_doll_component/update_icon()
	if(controller.selecting == limb_id)
		color = DARK_RED
	else
		color= DARK_BLUE

/obj/ui/target_doll_component/left_clicked_on(var/mob/clicker)
	. = ..()
	if(.)
		controller.set_selecting(limb_id)

/obj/ui/target_doll_component/right_clicked_on(var/mob/clicker)
	. = ..()
	if(.)
		controller.set_selecting(limb_id)

/obj/ui/target_doll_component/middle_clicked_on(var/mob/clicker)
	. = ..()
	if(.)
		controller.set_selecting(limb_id)
