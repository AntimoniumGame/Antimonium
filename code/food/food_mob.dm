/mob
	var/list/skin = list()
	var/list/consumable_effects = list()
	var/hunger = 100

/mob/proc/HandleHunger()
	if(hunger>0 && prob(1))
		hunger--
	hunger_meter.UpdateMeter(hunger)

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

	var/list/effects = skin.Copy()
	var/list/organs = GetHealthyOrgansByKey(ORGAN_STOMACH) + GetHealthyOrgansByKey(ORGAN_LUNG)

	for(var/thing in organs)
		var/obj/item/organ/organ = thing
		effects += organ.effects

	for(var/thing in effects)
		var/datum/effect/consumed = thing
		consumed.Tick()
