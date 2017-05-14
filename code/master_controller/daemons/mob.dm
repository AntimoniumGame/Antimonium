/data/daemon/mob
	name = "mob"
	delay = 10

/data/daemon/mob/do_work()
	for(var/thing in living_mob_list)
		var/mob/mob = thing
		if(mob && !deleted(mob))
			mob.handle_life_tick()
		check_suspend()

/data/daemon/mob/status()
	return "[living_mob_list.len]"