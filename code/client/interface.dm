/interface
	var/client/owner

/interface/New(client/C)
	if(istype(C))
		owner = C
		return 1
	return 0

/interface/proc/OnKeyPress(key)
	if(!key)
		return 0

	var/bind = owner.key_binds[key]
	if(!bind)
		return 0

	switch(bind)
		if(KEY_UP to KEY_LEFT)
			if(owner.mob)
				owner.mob.OnKeyPress(bind)
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
		if(KEY_VARS)
			owner.StartViewVars()

/interface/proc/OnKeyRelease(key)
	if(!key)
		return 0

	var/bind = owner.key_binds[key]
	if(!bind)
		return 0

	switch(bind)
		if(KEY_UP to KEY_LEFT)
			if(owner.mob)
				owner.mob.OnKeyRelease(bind)
		if(KEY_RUN)
			if(owner.mob)
				owner.mob.Walk()

/interface/proc/OnClick(object, location, control, params)
	if(owner.mob)
		var/modifiers = params2list(params)

		if(modifiers["middle"])
			owner.mob.MiddleClickOn(object, modifiers["ctrl"], modifiers["alt"])
		else if(modifiers["left"])
			owner.mob.LeftClickOn(object, modifiers["ctrl"], modifiers["alt"])
		else if(modifiers["right"])
			owner.mob.RightClickOn(object, modifiers["ctrl"], modifiers["alt"])


/interface/rebind
	var/cur_rebind

/interface/rebind/proc/SetRebind(rebind)
	if(rebind)
		cur_rebind = rebind

/interface/rebind/OnKeyPress(key)
	owner.Rebind(key, cur_rebind)

/interface/viewvars/OnClick(object, location, control, params)
	owner.ViewVars(object)
