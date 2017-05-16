/mob
	var/pain = 0
	var/shock = 0
	var/blood = 100

/mob/proc/handle_life_tick()
	// Update wounds, healing, shock, infection, etc.
	for(var/thing in injured_limbs)
		var/obj/item/limb/limb = thing
		limb.process()

	// Update some
	handle_pain()
	handle_bleeding()
	update_stance()
	health.update_icon()

/mob/proc/handle_pain()
	return

/mob/proc/handle_bleeding()
	if(dead)
		return

	blood = min(100, blood + 3)
	if(blood <= 60)
		die("blood loss")
	else if(prob(10))
		switch(blood)
			if(90 to 100)
				return
			if(80 to 90)
				notify("You feel slightly light-headed.")
			if(70 to 80)
				notify("The world lurches sickeningly as dizziness overtakes you.")
			if(60 to 70)
				notify("Flickering darkness swims at the edges of vour vision as you struggle to remain conscious.")
