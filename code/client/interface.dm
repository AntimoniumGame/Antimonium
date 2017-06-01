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
		if(KEY_DROP_R)
			if(owner.mob)
				owner.mob.DropSlot(SLOT_RIGHT_HAND)
		if(KEY_DROP_L)
			if(owner.mob)
				owner.mob.DropSlot(SLOT_LEFT_HAND)
		if(KEY_INTENT)
			if(owner.mob && owner.mob.intent)
				owner.mob.intent.SwapIntent()

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

/interface/lighttool/OnClick(object, location, control, params)
	set waitfor = 0
	var/turf/T = get_turf(object)
	var/list/pick_list = list()
	var/list/off_list = list()
	if(isarea(T.loc))
		pick_list["area lighting"] = T.loc
	for(var/obj/O in T)
		if(O.light_on)
			pick_list["[O] \ref[O]"] = O
		else
			off_list["[O] \ref[O] - Light Disabled"] = O

	var/list/full_list = pick_list + off_list
	var/selection = input(owner, "Select light source:") in full_list
	var/atom/A = full_list[selection]
	if(A)
		owner.PickLighttoolSource(A)
