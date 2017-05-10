/client
	var/interface/interface
	var/list/key_binds

/client/New()
	. = ..()
	loadData()
	if(!key_binds)
		key_binds = list("W" = KEY_UP,"S" = KEY_DOWN,"D" = KEY_RIGHT,"A" = KEY_LEFT, "Shift" = KEY_RUN, "Escape" = KEY_MENU, "Tab" = KEY_CHAT, "F8" = KEY_DEV)
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

/client/verb/onResize()
	var/string = winget(src, "map", "size")
	var/map_width = text2num(string)
	var/map_height = text2num(copytext(string,findtext(string,"x")+1,0))
	map_width = round(map_width / 64)
	map_height = round(map_height / 64)
	view = "[map_width]x[map_height]"

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
