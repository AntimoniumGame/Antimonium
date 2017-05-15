/client
	var/view_x = 0
	var/view_y = 0
	var/interface/interface
	var/list/key_binds

/client/New()
	view_x = round(world.view/2)
	view_y = round(world.view/2)
	. = ..()
	loadData()
	if(!key_binds)
		key_binds = list("W" = KEY_UP,"S" = KEY_DOWN,"D" = KEY_RIGHT,"A" = KEY_LEFT, "Shift" = KEY_RUN, "Escape" = KEY_MENU, "Tab" = KEY_CHAT, "F8" = KEY_DEV, "F7" = KEY_VARS)
	interface = new(src)

/client/verb/keyPress(key as text)
	set instant = 1
	set hidden = 1
	interface.onKeyPress(key)

/client/verb/keyRelease(key as text)
	set instant = 1
	set hidden = 1
	interface.onKeyRelease(key)

/client/verb/rebindKey()
	set name = "Rebind Key"

	var/selection = input("Select a command to rebind:") in __keylist

	var/interface/rebind/R = new(src)
	R.set_rebind(key2bind(selection))
	interface = R
	alert("Press ok, then the button you want to rebind \"[selection]\" to.")

/client/proc/rebind(key, bind)
	set waitfor = 0
	if(key && bind)
		var/old_bind = FindListAssociation(key_binds, bind)
		var/curbind = key_binds[key]
		if(curbind)
			var/response = alert("\"[key]\" is already bound to \"[bind2key(curbind)]\". Do you want to overwrite this?", null, "Yes", "No")
			if(response == "Yes")
				key_binds[key] = bind
				if(old_bind)
					key_binds[old_bind] = null
		else
			key_binds[key] = bind
			if(old_bind)
				key_binds[old_bind] = null
	interface = new(src)

/client/verb/on_resize()
	set hidden = 1

	var/string = winget(src, "map", "size")

	view_x = round(text2num(string) / 64)
	view_y = round(text2num(copytext(string,findtext(string,"x")+1,0)) / 64)
	view = "[view_x]x[view_y]"
	mob.on_window_resize()
/*
	#ifdef DEBUG
	dnotify("on_resize winget: [string], viewx: [view_x], viewy: [view_y]")
	#endif
*/
	// Workaround for a strange bug
	perspective = MOB_PERSPECTIVE
	eye = mob

/mob/proc/on_window_resize()
	for(var/obj/ui/ui_element in ui_screen)
		ui_element.center(client.view_x, client.view_y)

/mob
	var/tmp/key_x
	var/tmp/key_y
	var/tmp/walk_dir

/mob/proc/onKeyPress(bind)
	switch(bind)
		if(KEY_UP, KEY_DOWN)
			if(key_y)	//to prevent pressing opposite directions
				return 0
			walk_dir = key_y = bind2dir(bind)
		if(KEY_LEFT, KEY_RIGHT)
			if(key_x)	//as above
				return 0
			walk_dir = key_x = bind2dir(bind)

/mob/proc/onKeyRelease(bind)
	switch(bind)
		if(KEY_UP, KEY_DOWN)
			if(key_y != bind2dir(bind))	//ignore any ignored opposite key releases
				return 0
			key_y = 0
			walk_dir = key_x ? key_x : 0
		if(KEY_LEFT, KEY_RIGHT)
			if(key_x != bind2dir(bind))	//as above
				return 0
			key_x = 0
			walk_dir = key_y ? key_y : 0

//Click macro disable
/mob/verb/DisClick(argu = null as anything, sec = "" as text, number1 = 0 as num  , number2 = 0 as num)
	set name = ".click"
	set category = null
	return

/mob/verb/DisDblClick(argu = null as anything, sec = "" as text, number1 = 0 as num  , number2 = 0 as num)
	set name = ".dblclick"
	set category = null
	return
