/mob
	var/pain = 0
	var/shock = 0
	var/blood = 100

/mob/proc/HandleLifeTick()
	// Update wounds, healing, shock, infection, etc.
	for(var/thing in injured_limbs)
		var/obj/item/limb/limb = thing
		limb.Process()

	// Update some
	HandlePain()
	HandleBleeding()
	UpdateGrasp()
	UpdateStance()
	health.UpdateIcon()

/mob/proc/HandlePain()
	return

/mob/proc/UpdateGrasp()
	//TODO: move this to limbs
	var/obj/item/holding = GetEquipped(SLOT_LEFT_HAND)
	if(istype(holding) && holding.Burn(src, SLOT_HANDS))
		Notify("<span class='alert'>\The [holding] sears your left hand and falls from your grasp!</span>")
		DropItem(holding)
	holding = GetEquipped(SLOT_RIGHT_HAND)
	if(istype(holding) && holding.Burn(src, SLOT_HANDS))
		Notify("<span class='alert'>\The [holding] sears your right hand and falls from your grasp!</span>")
		DropItem(holding)

/mob/proc/HandleBleeding()
	if(dead)
		return

	blood = min(100, blood + 3)
	if(blood <= 60)
		Die("blood loss")
	else if(prob(10))
		switch(blood)
			if(90 to 100)
				return
			if(80 to 90)
				Notify("<span class='warning'>You feel slightly light-headed.</span>")
			if(70 to 80)
				Notify("<span class='danger'>The world lurches sickeningly as dizziness overtakes you.</span>")
			if(60 to 70)
				Notify("<span class='alert'>Flickering darkness swims at the edges of vour vision as you struggle to remain conscious.</span>")
