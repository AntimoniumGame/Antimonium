/mob
	var/dead

/mob/proc/die(var/cause)
	if(!dead)
		dead = TRUE
		if(!prone)
			toggle_prone()
		living_mob_list -= src
		dead_mob_list |= src
		notify_nearby("<b>\The [src] has been slain by [cause]!</b>")
		var/mob/abstract/ghost/goast = new(get_turf(src))
		goast.key = key
		goast.name = "ghost of [name]"
		goast.notify("<b>You have died and are now a spirit.</b>")
		return TRUE
	return FALSE
