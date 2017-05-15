/datum/admin_permissions/moderator
	associated_permission = PERMISSIONS_MODERATOR
	verbs = list(
		/client/proc/start_game,
		/client/proc/respawn
		)

var/force_start = FALSE
/client/proc/start_game()

	set name = "Force Start Game"
	set category = "Admin"

	if(force_start || (game_state && game_state.ident != GAME_LOBBY_WAITING))
		dnotify("Game is already starting or started.")
		return
	dnotify("Forcing game start.")
	force_start = TRUE

/client/proc/respawn()

	set name = "Respawn"
	set category = "Admin"

	var/mob/old_mob = mob
	var/mob/human/player_mob = new()
	player_mob.force_move(locate(3,3,1))
	player_mob.name = mob.key
	player_mob.key = mob.key
	qdel(old_mob)
