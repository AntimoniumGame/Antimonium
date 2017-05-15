/datum/admin_permissions/debug
	associated_permission = PERMISSIONS_DEBUG
	verbs = list(
		/client/proc/debug_controller,
		/client/proc/onResize,
		/client/proc/debug_controller,
		/client/proc/force_switch_game_state,
		/client/proc/testlights,
		/client/proc/set_client_fps
		)

/client/proc/DevPanel()
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