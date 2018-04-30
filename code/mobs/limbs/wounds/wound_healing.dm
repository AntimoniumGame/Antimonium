/datum/wound/proc/GetPain()
	var/pain = (depth * size)
	if(wound_type == WOUND_BURN)
		pain *= 2
	else if(wound_type == WOUND_BRUISE)
		pain *= 1.25
	else if(wound_type == WOUND_CUT && !bleed_amount)
		pain *= 0.75

/datum/wound/proc/Bleed()
	if(wound_type == WOUND_CUT && size > 3 && bleed_amount)
		if(!Bandaged())
			owner.RemoveOwnerBlood(max(1,round(size * 0.1)))
		bleed_amount = max(0, bleed_amount--)

/datum/wound/proc/Bandaged()
	return bandaged

/datum/wound/proc/CanRegenerate()
	return (size < 30 && (wound_type != WOUND_CUT || Bandaged()))

/datum/wound/proc/AttemptRegeneration(var/amount)

	if(!CanRegenerate())
		return

	if(depth > 1 && size > 1)
		amount = round(amount/2)
		depth = max(1, depth-amount)
		size = max(1, size-amount)
	else if(depth > 1)
		depth = max(1, depth-amount)
	else if(size > 1)
		size = max(1, size-amount)
	else
		QDel(src, "wound regeneration")
		return

	if(size < 3 && depth < 3 && bleed_amount)
		bleed_amount = 0

/datum/wound/Destroy()
	owner.wounds -= src
	owner = null
	. = ..()

/datum/wound/proc/Bandage()
	bandaged = TRUE

/datum/wound/proc/CanBandage()
	return (!Bandaged() && bleed_amount > 0 && wound_type == WOUND_CUT && size <= BANDAGE_THRESHOLD)

/datum/wound/proc/Reopen()
	bandaged = FALSE