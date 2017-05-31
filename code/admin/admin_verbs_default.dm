/datum/admin_permissions/moderator
	associated_permission = PERMISSIONS_MODERATOR
	verbs = list(
		/client/proc/Reboot,
		/client/proc/StartGame,
		/client/proc/Respawn,
		/client/proc/Spawn
		)

var/force_start = FALSE
/client/proc/StartGame()
	set name = "Force Start Game"
	set category = "Admin"
	if(game_state && game_state.ident != GAME_LOBBY_WAITING)
		Anotify("Game is already starting or started.")
		return
	var/datum/game_state/waiting/gstate = game_state
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
	var/mob/human/player_mob = new()
	player_mob.ForceMove(locate(3,3,1))
	player_mob.name = mob.key
	old_mob.TransferControlTo(player_mob)
	QDel(old_mob)

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

	Dnotify("Spawned [count]x[use_path] at [spawn_loc.x],[spawn_loc.y] (\the [spawn_loc]).")
	while(count>0)
		new use_path(spawn_loc)
		count--
