/mob
	var/obj/ui/window_holder/active_screen_window

/mob/proc/open_screen_window(var/xsize, var/ysize, var/window_name, var/obj/ui/report_to)

	if(active_screen_window)
		close_screen_window()

	active_screen_window = new(src, xsize, ysize, window_name, report_to)
	ui_screen += active_screen_window
	ui_screen += active_screen_window.close
	if(client)
		client.screen += active_screen_window
		client.screen += active_screen_window.close

/mob/proc/close_screen_window()
	if(active_screen_window)
		qdel(active_screen_window)
		active_screen_window = null

/obj/ui/window_holder
	icon = 'icons/images/ui_window.dmi'
	icon_state = "blank"
	screen_loc = "CENTER, CENTER"

	var/screen_height
	var/screen_width
	var/component_width = 32
	var/component_height = 32
	var/obj/ui/window_close/close
	var/obj/ui/report_to

/obj/ui/window_holder/New(var/mob/_owner, var/xsize, var/ysize, var/_name, var/obj/ui/_report_to)
	name = _name
	screen_width = max(2, min(10, xsize))
	screen_height = max(2, min(10, ysize))
	close = new(_owner, src)
	report_to = _report_to
	..(_owner)

/obj/ui/window_holder/update_strings()
	return

/obj/ui/window_holder/destroy()
	if(report_to)
		report_to.report_window_closed()
	if(owner && owner.active_screen_window == src)
		owner.active_screen_window = null
	if(close)
		close.controller = null
		qdel(close)
		close = null
	. = ..()

/obj/ui/window_holder/update_icon()
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

/obj/ui/window_holder/center(var/view_x, var/view_y)
	view_x = (round(view_x/2)-round(screen_width/2))+1
	view_y = (round(view_y/2)-round(screen_height/2))+2
	screen_loc = "[view_x],[view_y]"
	close.center(view_x + round(screen_width/2) - 1, view_y)

/obj/ui/window_close
	name = "Close Window"
	icon_state = "close"
	icon = 'icons/images/ui_window_buttons.dmi'
	var/obj/ui/window_holder/controller
	var/closing = FALSE

/obj/ui/window_close/center(var/view_x, var/view_y)
	screen_loc = "[view_x],[view_y]"

/obj/ui/window_close/New(var/mob/_owner, var/obj/ui/window_holder/_controller)
	controller = _controller
	plane = controller.plane
	layer = controller.layer + 0.1
	..(_owner)

/obj/ui/window_close/proc/close()
	if(!closing)
		closing = TRUE
		icon_state = "close_clicked"
		if(owner.client)
			play_client_sound(owner.client, null, 'sounds/effects/click1.wav', 100, -1)
		qdel(controller)

/obj/ui/window_close/destroy()
	if(controller)
		controller.close = null
		qdel(controller)
		controller = null
	..()

/obj/ui/window_close/left_clicked_on(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	close()

/obj/ui/window_close/right_clicked_on(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	close()

/obj/ui/window_close/middle_clicked_on(var/mob/clicker)
	close()
