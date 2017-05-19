/datum/admin_permissions/debug
	associated_permission = PERMISSIONS_DEBUG
	verbs = list(
		/client/proc/debug_controller,
		/client/proc/debug_controller,
		/client/proc/force_switch_game_state,
		/client/proc/set_client_fps,
		/client/proc/start_view_vars,
		/client/proc/toggle_vars_refresh,
		/client/proc/close_vars_window
		)

/client/proc/dev_panel()
	set waitfor = 0
	if(check_admin_permission(PERMISSIONS_DEBUG) && winget(src, "devwindow", "is-visible") == "false")
		winset(src, "devwindow", "is-visible=true")
	else
		winset(src, "devwindow", "is-visible=false")

/client/proc/debug_controller()

	set name = "Master Controller Status"
	set category = "Debug"

	if(!mc)
		dnotify("Master controller doesn't exist.")
		return
	dnotify("Daemons: [mc.daemons.len]")
	for(var/datum/daemon/daemon in mc.daemons)
		dnotify("[daemon.name]: [daemon.status()]")

/client/proc/force_switch_game_state()

	set name = "Force Game State"
	set category = "Debug"

	var/choice = input("Select a new state.") as null|anything in typesof(/datum/game_state)-/datum/game_state
	if(!choice) return
	to_chat(src, "Previous state path: [game_state ? game_state.type : "null"]")
	switch_game_state(choice)
	to_chat(src, "Forced state change complete.")

/client/proc/set_client_fps()

	set name = "Set Client FPS"
	set category = "Debug"

	fps = min(90, max(10, input("Enter a number between 10 and 90.") as num))

//var viewing madness below
/client/proc/start_view_vars()
	set waitfor = 0
	set name = "View Variables"
	set category = "Debug"

	if(check_admin_permission(PERMISSIONS_DEBUG))
		var/interface/viewvars/V = new(src)
		interface = V

/client/proc/view_vars(object)
	if(object)
		var/window_ref = "vars-\ref[object]"
		if(!winexists(src, window_ref))
			winclone(src, "varswindow", window_ref)
		if(winget(src, window_ref, "is-visible") == "false")
			winset(src, window_ref, "is-visible=true")
		winset(src, window_ref, "title=\"View Vars: [object]\"")
		winset(src, "[window_ref]", "on-close=\"close-vars-window [window_ref]\"")
		winset(src, "[window_ref].varsrefresh", "command=\"toggle-vars-refresh [window_ref]\"")
		src << output(object, "[window_ref].varselected")
		winset(src,"[window_ref].varsgrid","cells=2x0")
		src << output("Name", "[window_ref].varsgrid:1,1")
		src << output("Value", "[window_ref].varsgrid:2,1")
		update_view_vars(object)
	interface = new(src)

/client/proc/update_view_vars(object, win_ref)
	set waitfor = 0
	set background = 1

	var/datum/O = object
	if(!istype(O))
		if(win_ref)
			winset(src, win_ref, "title=\"View Vars: (Deleted)\"")
		return

	var/window_ref = "vars-\ref[O]"
	var/list/keylist = sort_list_keys(O.vars)

	var/first_run = TRUE
	while(O && winexists(src, window_ref) && (winget(src, "[window_ref].varsrefresh", "is-checked") == "true" || first_run))
		var/i = 2
		for(var/k in keylist)
			src << output("<a href='?function=varedit;var=[k];ref=\ref[O]'>[k]</a>" , "[window_ref].varsgrid:1,[i]")
			var/value = O.vars[k]
			if(isnull(value))
				src << output("null", "[window_ref].varsgrid:2,[i++]")
			else if(istype(value, /list))
				var/list/olist = value
				var/list_string = "/list = [olist.len]"
				if(k != "vars" && olist.len < 20) // grid elements wont scroll down a long cell
					for(var/o in olist)
						list_string = "[list_string]\n   - [o]"
				src << output(list_string, "[window_ref].varsgrid:2,[i++]")
			else if(istype(value, /atom))
				src << output(value, "[window_ref].varsgrid:2,[i++]")
			else if(istype(value, /datum))
				var/datum/d = value
				src << output("[d.type] ([d])", "[window_ref].varsgrid:2,[i++]")
			else if(k == "appearance")
				src << output("/appearance", "[window_ref].varsgrid:2,[i++]")
			else if(k == "flags" && istype(O, /atom))
				var/flag_list = "bitflags: [value]"
				var/bit = 1
				for(var/j = 1 to 16)
					if(value & bit)
						flag_list = "[flag_list]\n   [atomflag2name(bit)]"
					bit = bit<<1
				src << output(flag_list, "[window_ref].varsgrid:2,[i++]")
			else if((k == "sight" && ismob(O)) || (istype(O, /atom) && k in list("appearance_flags", "blend_mode")))
				src << output(flags_to_bits(value), "[window_ref].varsgrid:2,[i++]")
			else
				src << output("[value]", "[window_ref].varsgrid:2,[i++]")
		first_run = FALSE
		WAIT_1S

	if(!O)
		winset(src, window_ref, "title=\"View Vars: (Deleted)\"")

/proc/flags_to_bits(flags)
	var/flag_list = "bitflags: [flags]"
	var/bit = 1
	for(var/i = 1 to 16)
		if(flags & bit)
			flag_list = "[flag_list]\n   [bit]"
		bit = bit<<1
	return flag_list

/client/proc/toggle_vars_refresh(string as text)
	set hidden = 1
	var/datum/d = locate(copytext(string, 6))
	update_view_vars(d, string)

/client/proc/close_vars_window(string as text)
	set hidden = 1
	winset(src, string, "parent=none")

//Var editing madness below
/client/Topic(href,href_list[],hsrc)
	if(href_list["function"] == "varedit")
		if(check_admin_permission(PERMISSIONS_DEBUG))
			modify_var(src, href_list)
	else
		return ..()

/proc/modify_var(client/C, list/href_list)
	var/datum/D = locate(href_list["ref"])
	if(!istype(D))
		return
	var/V = D.vars[href_list["var"]]
	if(V in list("type", "parent_type", "vars") || istype(D, /atom) && V in list("locs"))
		C.dnotify("variable \"[V]\" is read-only")
	else
		var/var_name = null
		//there are only a couple of cases we need to know the var name
		if(href_list["var"] == "appearance" || (istype(D, /atom) && (href_list["var"] == "contents" || href_list["var"] == "flags")))
			var_name = href_list["var"]
		D.vars[href_list["var"]] = change_var(C, V, var_name)

//yes, this is a badass recursive-capable var editing proc
/proc/change_var(client/C, V = null, var_name = null)
	set background = 1

	var/type
	//beware the conditional chain - its in a debug call chain so thats my excuse for using one
	if(isnull(V))
		type = "null"
	else if(istext(V))
		type = "text"
	else if(var_name == "flags")
		type = "bitfield"
	else if(isnum(V))
		type = "number"
	else if(ispath(V))
		type = "path"
	else if(isfile(V))
		type = "file"
	else if(istype(V, /list))
		type = "list"
	else if(istype(V, /matrix))
		type = "matrix"
	else if(var_name == "appearance") // appearances are special snowflakes
		type = "appearance"
	else if(istype(V, /datum))
		var/choice = alert(C, "View or edit var?", null, "View", "Edit", "Cancel")
		switch(choice)
			if("View")
				C.view_vars(V)
				return V
			if("Edit")
				type = "datum"
			if("Cancel")
				return V
	else if(!V)
		//nothing - shouldn't ever get this far
		return null

	var/new_type = input(C, "Select type", null, type) in list("null", "bitfield", "number", "text", "path", "file", "list", "matrix", "appearance", "datum")
	switch(new_type)
		if("null")
			return null
		if("bitfield")
			var/choice = input(C, "Select bitflag to toggle:", "Var Edit") in __atom_flag_names
			if(V & __atom_flag_names[choice])
				V &= ~__atom_flag_names[choice]
			else
				V |= __atom_flag_names[choice]
			return V
		if("number")
			return input(C, "Enter number:", "Var Edit", V) as num|null
		if("text")
			return input(C, "Enter text:", "Var Edit", V) as text|null
		if("path")
			var/new_path = input(C, "Enter path:", "Var Edit", V) as text|null
			var/path = text2path(new_path)
			if(!path)
				var/selection = alert(C, "Path doesn't exist, do you want to set it to null?",null,"Yes","No")
				switch(selection)
					if("Yes")
						return null
					if("No")
						return V
			return path
		if("file")
			var/new_path = input(C, "Enter file path:", "Var Edit", V) as text|null
			var/new_file = file(new_path)
			if(!isfile(new_file))
				var/selection = alert(C, "Could not find file, do you want to set it to null?",null,"Yes","No")
				switch(selection)
					if("Yes")
						return null
					if("No")
						return V
			return new_file
		if("list")
			var/list/return_list = list()
			if(istype(V, /list))
				return_list = V
			var/list_entity = input(C, "Select list entity:", "List Edit") in return_list + list(" + new entry", "    wipe list", "    cancel")
			if(list_entity == " + new entry")
				var/more = "Yes"
				while(more == "Yes")
					var/new_entry = change_var(C)
					if(!isnull(new_entry) && (var_name != "contents" || istype(new_entry, /mob) || istype(new_entry, /obj))) // can only put mobs and objects in contents
						return_list.Add(new_entry)
					else
						C.dnotify("only mobs and objects can be added to an atoms contents list.")
					more = alert(C, "Add another entry?", null, "Yes", "No")
			else if(list_entity == "    cancel")
				return return_list
			else if(list_entity == "    wipe list")
				return list()
			else
				var/selection = alert(C, "How do you want to change this var?",null,"Edit","Remove")
				switch(selection)
					if("Edit")
						var/index = return_list.Find(list_entity)
						var/new_var = change_var(C, list_entity)
						return_list[index] = new_var
					if("Remove")
						return_list.Remove(list_entity)
			return return_list
		if("matrix")
			C.dnotify("matrix editing not implemented yet")
			return V
		if("appearance")
			C.dnotify("appearance editing not implemented yet")
			return V
		if("datum")
			C.dnotify("datum editing not implemented yet")
			return V
