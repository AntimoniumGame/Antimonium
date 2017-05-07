/client
	var/list/key_binds = list("W" = KEY_UP,"S" = KEY_DOWN,"D" = KEY_RIGHT,"A" = KEY_LEFT, "Shift" = KEY_RUN, "Escape" = KEY_MENU, "Tab" = KEY_CHAT)

/client/verb/keyPress(key as text)
	set instant = 1
	set hidden = 1
	var/bind = key_binds[key]
	if(bind)
		switch(bind)
			if(KEY_UP to KEY_LEFT)
				if(mob)
					mob.onKeyPress(bind)
			if(KEY_CHAT)
				if(winget(src, null, "focus") != "mainwindow.input")
					winset(src, "input", "focus=true")
				else
					winset(src, "map", "focus=true")
			if(KEY_RUN)
				if(mob)
					mob.Run()

/client/verb/keyRelease(key as text)
	set instant = 1
	set hidden = 1
	var/bind = key_binds[key]
	if(bind)
		switch(bind)
			if(KEY_UP to KEY_LEFT)
				if(mob)
					mob.onKeyRelease(bind)
			if(KEY_RUN)
				if(mob)
					mob.Walk()

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
