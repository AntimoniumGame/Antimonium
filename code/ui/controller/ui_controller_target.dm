/obj/ui/controller/target
	name = "Target Zone"
	screen_loc = "7,1"
	icon = 'icons/images/ui_doll.dmi'
	icon_state = "underlay_target"
	var/selecting = BP_CHEST

/obj/ui/controller/target/UpdateIcon(var/list/supplied = list())
	for(var/thing in components)
		var/obj/ui/component/target/component = thing
		component.UpdateIcon()

/obj/ui/controller/target/New(var/mob/_owner)
	..(_owner)
	components += new /obj/ui/component/target(_owner, src, list("name" = "upper body", "icon_state" = BP_CHEST))
	components += new /obj/ui/component/target(_owner, src, list("name" = "lower body", "icon_state" = BP_GROIN))
	components += new /obj/ui/component/target(_owner, src, list("name" = "head",       "icon_state" = BP_HEAD))
	components += new /obj/ui/component/target(_owner, src, list("name" = "left arm",   "icon_state" = BP_LEFT_ARM))
	components += new /obj/ui/component/target(_owner, src, list("name" = "left leg",   "icon_state" = BP_LEFT_LEG))
	components += new /obj/ui/component/target(_owner, src, list("name" = "left hand",  "icon_state" = BP_LEFT_HAND))
	components += new /obj/ui/component/target(_owner, src, list("name" = "left foot",  "icon_state" = BP_LEFT_FOOT))
	components += new /obj/ui/component/target(_owner, src, list("name" = "right arm",  "icon_state" = BP_RIGHT_ARM))
	components += new /obj/ui/component/target(_owner, src, list("name" = "right leg",  "icon_state" = BP_RIGHT_LEG))
	components += new /obj/ui/component/target(_owner, src, list("name" = "right hand", "icon_state" = BP_RIGHT_HAND))
	components += new /obj/ui/component/target(_owner, src, list("name" = "right foot", "icon_state" = BP_RIGHT_FOOT))

/obj/ui/controller/target/GetInputFrom(var/obj/ui/component/component)
	selecting = component.icon_state
	UpdateIcon()

/obj/ui/component/target/UpdateIcon(var/list/supplied = list())
	var/obj/ui/controller/target/target_control = controller
	color = (target_control.selecting == icon_state ? DARK_RED : DARK_BLUE)
