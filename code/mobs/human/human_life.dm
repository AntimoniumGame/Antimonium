/mob/human
	var/pain = 0    //
	var/shock = 0
	var/blood = 100
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

/mob/human/proc/handle_pain()
	return

/mob/human/proc/handle_bleeding()
	return

/mob/human/update_stance()
	set background = 1
	set waitfor = 0
	sleep(1)
	if(prone)
		return
	var/stance_score = 0
	for(var/limb_id in list(BP_LEFT_LEG, BP_RIGHT_LEG, BP_LEFT_FOOT, BP_RIGHT_FOOT))
		var/obj/item/limb/stance/limb = limbs[limb_id]
		if(limb && !limb.broken)
			stance_score += limb.support_value
	if(stance_score <= 3)
		notify_nearby("\The [src] collapses!")
		toggle_prone()
