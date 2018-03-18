/datum/daemon/mob
	name = "mob"
	delay = 10

/datum/daemon/mob/DoWork()
	for(var/thing in glob.living_mob_list)
		var/mob/mob = thing
		if(mob && !Deleted(mob))
			mob.HandleLifeTick()
		CHECK_SUSPEND

/datum/daemon/mob/Status()
	return "[glob.living_mob_list.len]"