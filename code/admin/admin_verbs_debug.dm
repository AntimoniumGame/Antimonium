/datum/admin_permissions/debug
	associated_permission = PERMISSIONS_DEBUG
	verbs = list(
		/client/proc/debug_controller,
		/client/proc/test_resize,
		/client/proc/debug_controller,
		/client/proc/force_switch_game_state,
		/client/proc/testlights,
		/client/proc/set_client_fps,
		/client/proc/start_view_vars
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

/client/proc/test_resize()
	set name = "Test onResize()"
	set category = "Debug"
	onResize()

/client/proc/start_view_vars()
	set waitfor = 0
	set name = "View Variables"
	set category = "Debug"

	if(winget(src, "varswindow", "is-visible") == "false")
		winset(src, "varswindow", "is-visible=true")
	var/interface/viewvars/V = new(src)
	interface = V

/client/proc/view_vars(object)
	winset(src, "varswindow", "title=\"View Vars: [object]\"")
	src << output(object, "varselected")
	winset(src,"varsgrid","cells=2x0")
	src << output("Name", "varsgrid:1,1")
	src << output("Value", "varsgrid:2,1")
	update_view_vars(object)
	interface = new(src)

/client/proc/update_view_vars(var/object)
	set waitfor = 0

	var/atom/O = object
	var/list/keylist = sort_list_keys(O.vars)

	var/first_run = TRUE
	while(O && (winget(src, "varsrefresh", "is-checked") == "true" || first_run))
		var/i = 2
		for(var/k in keylist)
			src << output(k, "varsgrid:1,[i]")
			var/value = O.vars[k]
			if(isnull(value))
				src << output("null", "varsgrid:2,[i++]")
			else if(istype(value,/list))
				var/list/olist = value
				src << output("/list = [olist.len]", "varsgrid:2,[i++]")
			else
				if(istype(value, /datum))
					var/datum/d = value
					src << output("[d.type] ([d])", "varsgrid:2,[i++]")
				else
					src << output("[value]", "varsgrid:2,[i++]")
		first_run = FALSE
		WAIT_1S
