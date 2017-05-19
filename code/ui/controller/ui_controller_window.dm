/mob
	var/obj/ui/controller/window_holder/active_screen_window

/mob/proc/open_screen_window(var/xsize, var/ysize, var/window_name, var/obj/ui/report_to)

	if(active_screen_window)
		close_screen_window()

	active_screen_window = new(src, xsize, ysize, window_name, report_to)

	if(client)
		client.screen += active_screen_window
		client.screen += active_screen_window.close

/mob/proc/close_screen_window()
	if(active_screen_window)
		qdel(active_screen_window)
		active_screen_window = null

/obj/ui/controller/window_holder
	icon = 'icons/images/ui_window.dmi'
	icon_state = "blank"
	screen_loc = "CENTER, CENTER"

	var/screen_height
	var/screen_width
	var/component_width = 32
	var/component_height = 32
	var/obj/ui/component/close/close
	var/obj/ui/report_to

/obj/ui/controller/window_holder/New(var/mob/_owner, var/xsize, var/ysize, var/_name, var/obj/ui/_report_to)
	screen_width = max(2, min(10, xsize))
	screen_height = max(2, min(10, ysize))
	close = new(_owner, src)
	..(_owner)
	name = _name
	report_to = _report_to

/obj/ui/controller/window_holder/get_input_from(var/obj/ui/component/component)
	if(owner.client) play_client_sound(owner.client, null, 'sounds/effects/click1.wav', 100, -1)
	qdel(src)

/obj/ui/controller/window_holder/update_strings()
	return

/obj/ui/controller/window_holder/destroy()
	if(report_to)
		report_to.report_window_closed()
	if(owner && owner.active_screen_window == src)
		owner.active_screen_window = null
	if(close)
		close.controller = null
		qdel(close)
		close = null
	. = ..()

/obj/ui/controller/window_holder/update_icon()
	var/list/component_overlays = list()
	for(var/tx = 1 to screen_width)
		for(var/ty = 1 to screen_height)
			var/cell_icon_state
			if(tx == 1)
				if(ty == 1)
					cell_icon_state = "sw"
				else if(ty == screen_height)
					cell_icon_state = "nw"
				else
					cell_icon_state = "w"
			else if(tx == screen_width)
				if(ty == 1)
					cell_icon_state = "se"
				else if(ty == screen_height)
					cell_icon_state = "ne"
				else
					cell_icon_state = "e"
			else if(ty == 1)
				cell_icon_state = "s"
			else if(ty == screen_height)
				cell_icon_state = "n"
			else
				cell_icon_state = "inner"
			var/image/cell = image(icon, cell_icon_state)
			cell.pixel_x = (tx-1)*component_width
			cell.pixel_y = (ty-1)*component_height
			component_overlays += cell
	overlays = component_overlays

/obj/ui/controller/window_holder/center(var/view_x, var/view_y)
	view_x = (round(view_x/2)-round(screen_width/2))+1
	view_y = (round(view_y/2)-round(screen_height/2))+2
	screen_loc = "[view_x],[view_y]"
	close.center(view_x, view_y)

/obj/ui/component/close
	name = "Close Window"
	icon_state = "close"

/obj/ui/component/close/update_icon()
	icon = 'icons/images/ui_window_buttons.dmi'

/obj/ui/component/close/center(var/view_x, var/view_y)
	var/obj/ui/controller/window_holder/holder = controller
	screen_loc = "[view_x + round(holder.screen_width/2) - 1],[view_y]"
