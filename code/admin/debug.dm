/client/proc/DevPanel()
	set waitfor = 0
	//TODO: write permissions code
	if(winget(src, "devwindow", "is-visible") == "false")
		winset(src, "devwindow", "is-visible=true")
	else
		winset(src, "devwindow", "is-visible=false")

/client/verb/debug_controller()

	set name = "Master Controller Status"
	set category = "Debug"

	if(!mc)
		dnotify("MC doesn't exist.")
		return
	dnotify("Daemons: [mc.daemons.len]")
	for(var/data/daemon/daemon in mc.daemons)
		dnotify("[daemon.name]: [daemon.status()]")

/client/verb/force_switch_game_state()

	set name = "Force Game State"
	set category = "Debug"

	var/choice = input("Select a new state.") as null|anything in typesof(/data/game_state)-/data/game_state
	if(!choice) return
	to_chat(src, "Previous state path: [game_state ? game_state.type : "null"]")
	switch_game_state(choice)
	to_chat(src, "Forced state change complete.")

/client/verb/testlights()

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

/client/verb/dress_self()

	set name = "Dress Self"
	set category = "Debug"

	var/mob/human/human = mob
	if(!istype(human))
		dnotify("Only works on humans, sorry.")
		return

	if(!mob.get_equipped(SLOT_UPPER_BODY))
		mob.collect_item_or_del(new /obj/item/clothing/shirt(), SLOT_UPPER_BODY)
	if(!mob.get_equipped(SLOT_LOWER_BODY))
		mob.collect_item_or_del(new /obj/item/clothing/pants(), SLOT_LOWER_BODY)
	if(!mob.get_equipped(SLOT_FEET))
		mob.collect_item_or_del(new /obj/item/clothing/boots(), SLOT_FEET)

	dnotify("Mob dressed.")

var/force_start = FALSE
/client/verb/start_game()

	set name = "Force Start Game"
	set category = "Debug"

	if(force_start || (game_state && game_state.ident != GAME_LOBBY_WAITING))
		dnotify("Game is already starting or started.")
		return
	dnotify("Forcing game start.")
	force_start = TRUE

/client/verb/respawn()

	set name = "Respawn"
	set category = "Debug"

	var/mob/old_mob = mob
	var/mob/human/player_mob = new()
	player_mob.force_move(locate(3,3,1))
	player_mob.name = mob.key
	player_mob.key = mob.key
	qdel(old_mob)

/client/verb/gibself()

	set name = "Gibself"
	set category = "Debug"

	var/mob/human/victim = mob
	if(!istype(victim))
		dnotify("Only works on humans, sorry.")
		return

	blood_splatter(mob, mob)
	while(victim.limbs.len > 1)
		var/obj/item/limb/limb = victim.limbs[pick(victim.limbs - BP_CHEST)]
		limb.sever_limb()
		sleep(-1)
