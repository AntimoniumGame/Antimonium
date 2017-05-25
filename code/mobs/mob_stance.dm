/mob
	var/stance_fail_threshold = 3
	var/stance_limbs = list(BP_LEFT_LEG, BP_RIGHT_LEG, BP_LEFT_FOOT, BP_RIGHT_FOOT)
	var/stance_score = 0
	var/prone = FALSE

/mob/proc/ToggleProne()
	prone = !prone
	density = !prone
	if(prone && sitting)
		ToggleSitting()
	else
		UpdateIcon()

/mob/proc/UpdateStance()
	set waitfor = 0
	sleep(1)
	if(prone || sitting)
		return
	stance_score = 0
	for(var/limb_id in stance_limbs)
		var/obj/item/limb/stance/limb = limbs[limb_id]
		if(limb && !limb.broken)
			stance_score += limb.support_value
	if(stance_score <= stance_fail_threshold)
		NotifyNearby("<b>\The [src] collapses!</b>")
		ToggleProne()

/mob/proc/HandleStanceMoveDelay()
	. = 0
	if(stance_score <= 5)
		. += 1
	if(stance_score <= 3)
		. += 2
