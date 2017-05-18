/obj/ui/toggle/options
	name = "Options"
	icon = 'icons/images/ui_title_buttons.dmi'
	base_icon_state = "options"
	var/window_name = "Options"

/obj/ui/toggle/options/center(var/view_x, var/view_y)
	screen_loc = "[round(view_x/2)]-2,[round(view_y/2)-4]"

/obj/ui/toggle/options/toggle_state()
	..()
	if(!toggle_state)
		owner.close_screen_window()
	else
		owner.open_screen_window(6, 8, window_name, src)

/obj/ui/toggle/options/report_window_closed()
	toggle_state = FALSE
	update_icon()

/obj/ui/toggle/options/prefs
	name = "Set Up Preferences"
	base_icon_state = "setup"
	window_name = "Preferences"

/obj/ui/toggle/options/prefs/center(var/view_x, var/view_y)
	screen_loc = "[round(view_x/2)],[round(view_y/2)-4]"
