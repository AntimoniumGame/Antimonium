/mob
	var/dead

/mob/proc/Die(var/cause)
	if(!dead)
		if(radial_menu)
			QDel(radial_menu, "owner death")
		dead = TRUE
		if(!prone)
			ToggleProne()
		glob.living_mob_list -= src
		glob.dead_mob_list |= src
		NotifyNearby("<span class='alert'><b>\The [src] has been slain by [cause]!</b></span>", MESSAGE_VISIBLE)
		if(client)
			var/mob/abstract/ghost/goast = new(get_turf(src))
			TransferControlTo(goast)
			goast.name = "ghost of [name]"
			goast.Notify("<b>You have died and are now a spirit.</b>")
		CheckGameCompletion()
		return TRUE
	return FALSE
