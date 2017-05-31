/mob
	var/dead

/mob/proc/Die(var/cause)
	if(!dead)
		dead = TRUE
		if(!prone)
			ToggleProne()
		living_mob_list -= src
		dead_mob_list |= src
		NotifyNearby("<b>\The [src] has been slain by [cause]!</b>")
		var/mob/abstract/ghost/goast = new(get_turf(src))
		TransferControlTo(goast)
		goast.name = "ghost of [name]"
		goast.Notify("<b>You have died and are now a spirit.</b>")
		return TRUE
	return FALSE
