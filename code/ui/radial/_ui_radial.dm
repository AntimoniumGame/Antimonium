/mob
	var/obj/ui/radial_menu/radial_menu

/mob/Destroy()
	QDel(radial_menu)
	. = ..()

/obj/ui/radial_button
	var/obj/ui/radial_menu/parent_menu

/obj/ui/radial_button/close/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	. = ..()
	if(.)
		QDel(parent_menu)

/obj/ui/radial_button/Destroy()
	parent_menu = null
	. = ..()

/obj/ui/radial_button/New(var/mob/_owner, var/obj/ui/radial_menu/_parent_menu)
	..(_owner)
	parent_menu = _parent_menu
	plane = parent_menu.plane
	layer = parent_menu.layer + 2

/obj/ui/radial_button/close
	name = "Close"
	icon = 'icons/images/ui_radial_close.dmi'

/obj/ui/radial_button/close/New(var/mob/_owner, var/obj/ui/radial_menu/_parent_menu)
	..(_owner, _parent_menu)
	layer++

/obj/ui/radial_button/atom
	var/atom/refer_atom

/obj/ui/radial_button/atom/Destroy()
	refer_atom = null
	. = ..()

/obj/ui/radial_button/atom/New(var/mob/_owner, var/obj/ui/radial_menu/_parent_menu, var/atom/_refer_atom)
	refer_atom = _refer_atom
	name = refer_atom.name
	..(_owner, _parent_menu)
	UpdateAppearance()

/obj/ui/radial_button/atom/proc/UpdateAppearance()
	appearance = refer_atom
	plane = parent_menu.plane
	layer = parent_menu.layer + 1
	var/atom/movable/object = refer_atom
	if(!istype(object) || isnull(object.draw_shadow_underlay))
		draw_shadow_underlay = TRUE
		UpdateShadowUnderlay()

/obj/ui/radial_button/atom/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	. = ..()
	if(.  && refer_atom && !Deleted(refer_atom) && IsAdjacentTo(clicker, refer_atom))
		refer_atom.LeftClickedOn(clicker, slot)
	parent_menu.UpdateButtons()

/obj/ui/radial_button/atom/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	. = ..()
	if(.  && refer_atom && !Deleted(refer_atom) && IsAdjacentTo(clicker, refer_atom))
		refer_atom.RightClickedOn(clicker, slot)
	parent_menu.UpdateButtons()

/obj/ui/radial_button/atom/MiddleClickedOn(var/mob/clicker)
	. = ..()
	if(.  && refer_atom && !Deleted(refer_atom) && IsAdjacentTo(clicker, refer_atom))
		refer_atom.MiddleClickedOn(clicker)

/obj/ui/radial_menu
	name = "Radial Menu"
	icon = 'icons/images/ui_radial_menu.dmi'

	var/atom/source_atom
	var/screen_loc_x
	var/screen_loc_y
	var/list/buttons = list()
	var/obj/ui/radial_button/close/close_button
	var/obj/ui/source_atom_display

/obj/ui/radial_menu/Destroy()
	QDel(source_atom_display)
	source_atom_display = null
	for(var/thing in buttons)
		if(!Deleted(thing))
			QDel(thing)
	buttons.Cut()
	if(owner && owner.radial_menu == src)
		owner.radial_menu = null
	. = ..()

/obj/ui/radial_menu/New(var/mob/_owner, var/list/_source_atom)

	if(!_owner.client || !_source_atom)
		QDel(src)
		return

	source_atom = _source_atom
	source_atom_display = new(_owner)
	source_atom_display.name = source_atom.name
	source_atom_display.appearance = source_atom
	source_atom_display.plane = plane
	source_atom_display.layer = layer+3
	var/atom/movable/object = source_atom
	if(!istype(object) || isnull(object.draw_shadow_underlay))
		source_atom_display.draw_shadow_underlay = TRUE
		source_atom_display.UpdateShadowUnderlay()


	close_button = new(_owner, src)

	if(_owner.radial_menu)
		QDel(_owner.radial_menu)
	_owner.radial_menu = src

	..(_owner)

	var/list/clickdata = splittext(owner.client.last_click["screen-loc"], ",")
	var/list/data_x = splittext(clickdata[1], ":")
	var/list/data_y = splittext(clickdata[2], ":")

	screen_loc_x = text2num(data_x[1])
	screen_loc_y = text2num(data_y[1])
	screen_loc = "[screen_loc_x-2],[screen_loc_y-2]"
	source_atom_display.screen_loc = "[screen_loc_x],[screen_loc_y]"

	UpdateButtons()

/obj/ui/radial_menu/proc/UpdateButtons()

	var/list/displaying = source_atom.GetRadialMenuContents(owner)

	buttons -= close_button

	for(var/thing in buttons)
		var/obj/ui/radial_button/atom/button = thing
		if(locate("\ref[button.refer_atom]") in displaying)
			displaying -= button.refer_atom
			button.UpdateAppearance()
			continue
		buttons -= button
		QDel(button)

	for(var/thing in displaying)
		buttons += new /obj/ui/radial_button/atom(owner, src, thing)

	buttons.Insert(1, close_button)

	var/use_angle = 0
	var/angle_step = round(360/buttons.len)
	for(var/thing in buttons)
		var/obj/ui/radial_button/button = thing
		button.screen_loc = "[screen_loc_x+1]:[-32+round(58 * cos(use_angle-90))], [screen_loc_y+1]:[-32+round(58 * sin(use_angle-90))]"
		use_angle += angle_step
		if(use_angle > 360)
			use_angle -= 360

	owner.RefreshUI()
