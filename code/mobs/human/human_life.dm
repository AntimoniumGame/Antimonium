#define BLOOD_HEAL_PER_TICK 3

/mob/human
	var/pain = 0
	var/shock = 0
	var/blood = 100
	var/stance_score = 0
	var/list/injured_limbs = list()

/mob/human/handle_life_tick()

	// Update wounds, healing, shock, infection, etc.
	for(var/thing in injured_limbs)
		var/obj/item/limb/limb = thing
		limb.process()

	// Update some
	handle_pain()
	handle_bleeding()
	update_stance()
	health.update_icon()

/mob/human/proc/handle_pain()
	return

/mob/human/proc/handle_bleeding()
	if(dead)
		return

	blood = min(100, blood+BLOOD_HEAL_PER_TICK)
	if(blood <= 0)
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

/mob/human/update_stance()
	set background = 1
	set waitfor = 0
	sleep(1)
	if(prone)
		return
	stance_score = 0
	for(var/limb_id in list(BP_LEFT_LEG, BP_RIGHT_LEG, BP_LEFT_FOOT, BP_RIGHT_FOOT))
		var/obj/item/limb/stance/limb = limbs[limb_id]
		if(limb && !limb.broken)
			stance_score += limb.support_value
	if(stance_score <= 3)
		notify_nearby("<b>\The [src] collapses!</b>")
		toggle_prone()

#undef BLOOD_HEAL_PER_TICK