/mob
	var/stance_fail_threshold = 3
	var/stance_limbs = list(BP_LEFT_LEG, BP_RIGHT_LEG, BP_LEFT_FOOT, BP_RIGHT_FOOT)
	var/stance_score = 0
	var/prone = FALSE

/mob/proc/IsAlive()
	return !dead

/mob/proc/CanStand()
	if(!IsAlive() || HasEffect(EFFECT_UNCONSCIOUS))
		return FALSE
	stance_score = 0
	for(var/limb_id in stance_limbs)
		var/obj/item/limb/stance/limb = GetLimb(limb_id)
		if(limb && !limb.broken)
			stance_score += limb.support_value
	return !(stance_score <= stance_fail_threshold || prob(GetEffectPower(EFFECT_DIZZY)))

/mob/proc/ToggleProne(var/deliberate = FALSE)
	prone = !prone
	density = !prone
	if(prone && sitting)
		ToggleSitting()
	else
		UpdateIcon()

	if(deliberate)
		if(!prone)
			Notify("<span class='notice'>You stand up.</span>")
		else
			if(sitting)
				Notify("<span class='notice'>You sit down.</span>")
			else
				Notify("<span class='notice'>You lie down.</span>")

	if(stand)
		stand.UpdateIcon()

/mob/proc/UpdateStance()
	if(prone || sitting)
		return
	if(!CanStand())
		NotifyNearby("<span class='danger'><b>\The [src] collapses!</b></span>")
		ToggleProne()

/mob/proc/HandleStanceMoveDelay()
	. = 0
	if(stance_score <= (stance_fail_threshold+2))
		. += 1
	if(stance_score <= stance_fail_threshold)
		. += 2
