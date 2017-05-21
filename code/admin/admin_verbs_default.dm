/datum/admin_permissions/moderator
	associated_permission = PERMISSIONS_MODERATOR
	verbs = list(
		/client/proc/ListOnline,
		/client/proc/StartGame,
		/client/proc/Respawn
		)

var/force_start = FALSE
/client/proc/StartGame()

	set name = "Force Start Game"
	set category = "Admin"

	if(force_start || (game_state && game_state.ident != GAME_LOBBY_WAITING))
		Anotify("Game is already starting or started.")
		return
	Anotify("Forcing game start.")
	force_start = TRUE

/client/proc/ListOnline()

	set name = "Who"
	set category = "Admin"

	for(var/client/player in clients)
		if(player.admin_permissions)
			Anotify("[player.key] (<b>[player.admin_permissions.title]</b>)")
		else
			Anotify("[player.key]")

/client/proc/Respawn()

	set name = "Respawn"
	set category = "Admin"

	var/mob/old_mob = mob
	var/mob/human/player_mob = new()
	player_mob.ForceMove(locate(3,3,1))
	player_mob.name = mob.key
	player_mob.key = mob.key
	QDel(old_mob)
