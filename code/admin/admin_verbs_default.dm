/datum/admin_permissions/moderator
	associated_permission = PERMISSIONS_MODERATOR
	verbs = list(
		/client/proc/Reboot,
		/client/proc/StartGame,
		/client/proc/Respawn,
		/client/proc/Spawn,
		/client/proc/ShowHubStatus,
		/client/proc/ToggleHubVisibility
		)

/client/proc/ToggleHubVisibility()
	set name = "Toggle Hub Visibility"
	set category = "Admin"

	world.visibility = !world.visibility
	MassAnotify("[usr.key] [world.visibility ? "enabled" : "disabled"] server hub visibility.")

/client/proc/ShowHubStatus()
	set name = "Show Hub Status"
	set category = "Admin"

	to_chat(src, "Server is [world.visibility ? "visible" : "invisible"] to the hub.")
	to_chat(src, "Hub status is: [world.status]")
	to_chat(src, "Hub name is: [world.name]")
	to_chat(src, "Hub ID is: [world.hub]")

/client/proc/StartGame()
	set name = "Force Start Game"
	set category = "Admin"
	if(_glob.game_state && _glob.game_state.ident != GAME_LOBBY_WAITING)
		Anotify("Game is already starting or started.")
		return
	var/datum/game_state/waiting/gstate = _glob.game_state
	if(!istype(gstate) || gstate.force_start)
		Anotify("Game is already starting or started.")
		return
	Anotify("Forcing game start.")
	gstate.force_start = TRUE

/client/proc/Reboot()

	set name = "Reboot Server"
	set category = "Admin"

	if((input("Are you sure you want to reboot the world?") as anything in list("No","Yes")) == "Yes")
		to_chat(world, "<b>Server rebooting - initiated by [key]!</b>")
		sleep(5)
		world.Reboot()

/client/proc/Respawn()

	set name = "Respawn"
	set category = "Admin"

	var/mob/old_mob = mob
	mob.TransferControlTo(new /mob/abstract/new_player())
	QDel(old_mob, "respawning")

/client/proc/Spawn(var/msg as text)

	set name = "Spawn Atom"
	set category = "Admin"

	var/use_path = text2path(msg)
	if(!ispath(use_path))
		Dnotify("'[msg]' is not a valid atom path.")
		return

	var/turf/spawn_loc = get_turf(mob)
	if(!istype(spawn_loc))
		Dnotify("Couldn't get a turf for your mob, are you in nullspace?")
		return

	var/count = min(100,max(0,input("How many? (1-100)",1) as num|null))
	if(!count || count < 1)
		return

	MassDnotify("[usr.ckey] spawned [count]x[use_path] at [spawn_loc.x],[spawn_loc.y] (\the [spawn_loc]).")
	while(count>0)
		new use_path(spawn_loc)
		count--
