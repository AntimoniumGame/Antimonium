/mob
	var/list/stomach = list()
	var/list/skin = list()
	var/list/lungs = list()
	var/list/consumable_effects = list()
	var/hunger = 100

/mob/proc/HandleHunger()
	if(hunger>0 && prob(1))
		hunger--
/*
	if(prob(5))
		switch(hunger)
			if(20 to 30)
				Notify("<span class='warning'>Your stomach growls.</span>")
			if(10 to 19)
				Notify("<span class='danger'>You feel a sharp pang of hunger.</span>")
			if(0 to 9)
				Notify("<span class='alert'>You are starving!</span>")
*/

/mob/proc/HandleConsumableEffects()
	consumable_effects = list()
	for(var/thing in (stomach|skin|lungs))
		var/datum/effect/consumed = thing
		consumed.Tick()
