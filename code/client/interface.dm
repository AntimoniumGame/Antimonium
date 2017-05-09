/interface
	var/client/owner

/interface/New(client/C)
	if(istype(C))
		owner = C
		return 1
	return 0

/interface/proc/onKeyPress(key)
	if(!key)
		return 0

	var/bind = owner.key_binds[key]
	if(!bind)
		return 0

	switch(bind)
		if(KEY_UP to KEY_LEFT)
			if(owner.mob)
				owner.mob.onKeyPress(bind)
		if(KEY_CHAT)
			if(winget(owner, null, "focus") != "mainwindow.input")
				winset(owner, "input", "focus=true")
			else
				winset(owner, "map", "focus=true")
		if(KEY_RUN)
			if(owner.mob)
				owner.mob.Run()
		if(KEY_DEV)
			owner.DevPanel()

/interface/proc/onKeyRelease(key)
	if(!key)
		return 0

	var/bind = owner.key_binds[key]
	if(!bind)
		return 0

	switch(bind)
		if(KEY_UP to KEY_LEFT)
			if(owner.mob)
				owner.mob.onKeyRelease(bind)
		if(KEY_RUN)
			if(owner.mob)
				owner.mob.Walk()

/interface/rebind
	var/cur_rebind

/interface/rebind/proc/set_rebind(rebind)
	if(rebind)
		cur_rebind = rebind

/interface/rebind/onKeyPress(key)
	owner.rebind(key, cur_rebind)
