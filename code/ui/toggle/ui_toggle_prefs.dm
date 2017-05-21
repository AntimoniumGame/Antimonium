/obj/ui/toggle/options
	name = "Options"
	icon = 'icons/images/ui_title_buttons.dmi'
	base_icon_state = "options"
	var/window_name = "Options"

/obj/ui/toggle/options/Center(var/view_x, var/view_y)
	screen_loc = "[round(view_x/2)]-2,[round(view_y/2)-4]"

/obj/ui/toggle/options/ToggleState()
	..()
	if(!toggle_state)
		owner.CloseScreenWindow()
	else
		owner.OpenScreenWindow(6, 8, window_name, src)

/obj/ui/toggle/options/ReportWindowClosed()
	toggle_state = FALSE
	UpdateIcon()

/obj/ui/toggle/options/prefs
	name = "Set Up Preferences"
	base_icon_state = "setup"
	window_name = "Preferences"

/obj/ui/toggle/options/prefs/Center(var/view_x, var/view_y)
	screen_loc = "[round(view_x/2)],[round(view_y/2)-4]"
