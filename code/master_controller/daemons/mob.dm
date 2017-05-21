/datum/daemon/mob
	name = "mob"
	delay = 10

/datum/daemon/mob/DoWork()
	for(var/thing in living_mob_list)
		var/mob/mob = thing
		if(mob && !Deleted(mob))
			mob.HandleLifeTick()
		CheckSuspend()

/datum/daemon/mob/Status()
	return "[living_mob_list.len]"