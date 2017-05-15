/datum/admin_permissions/debug
	associated_permission = PERMISSIONS_DEBUG
	verbs = list(
		/client/proc/debug_controller,
		/client/proc/debug_controller,
		/client/proc/force_switch_game_state,
		/client/proc/testlights,
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
		dnotify("MC doesn't exist.")
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

/client/proc/testlights()

	set name = "Toggle Self Light"
	set category = "Debug"

	mob.light_power = 10
	mob.light_range = 5
	mob.light_color = WHITE
	mob.light_type = LIGHT_SOFT

	if(mob.light_obj)
		mob.dnotify("Killed self light.")
		mob.kill_light()
	else
		mob.dnotify("Set self light.")
		mob.set_light()

	sleep(5)
	if(mob.light_obj)
		mob.light_obj.follow_holder()

/client/proc/set_client_fps()

	set name = "Set Client FPS"
	set category = "Debug"

	fps = min(90, max(10, input("Enter a number between 10 and 90.") as num))

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
			src << output(k, "[window_ref].varsgrid:1,[i]")
			var/value = O.vars[k]
			if(isnull(value))
				src << output("null", "[window_ref].varsgrid:2,[i++]")
			else if(istype(value,/list))
				var/list/olist = value
				src << output("/list = [olist.len]", "[window_ref].varsgrid:2,[i++]")
			else
				if(istype(value, /atom))
					src << output(value, "[window_ref].varsgrid:2,[i++]")
				else if(istype(value, /datum))
					var/datum/d = value
					src << output("[d.type] ([d])", "[window_ref].varsgrid:2,[i++]")
				else
					src << output("[value]", "[window_ref].varsgrid:2,[i++]")
		first_run = FALSE
		WAIT_1S

	if(!O)
		winset(src, window_ref, "title=\"View Vars: (Deleted)\"")

/client/proc/toggle_vars_refresh(string as text)
	set hidden = 1
	var/datum/d = locate(copytext(string, 6))
	update_view_vars(d, string)

/client/proc/close_vars_window(string as text)
	set hidden = 1
	winset(src, string, "parent=none")
