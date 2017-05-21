/datum/wound/proc/Bleed()
	if(wound_type == WOUND_CUT && severity > 3 && bleed_amount)
		owner.RemoveOwnerBlood(max(1,round(severity * 0.1)))
		bleed_amount = max(0, bleed_amount--)

/datum/wound/proc/Bandaged()
	return FALSE

/datum/wound/proc/CanRegenerate()
	return (severity < 30 && (wound_type != WOUND_CUT || Bandaged()))

/datum/wound/proc/AttemptRegeneration(var/amount)

	if(!CanRegenerate())
		return

	if(depth > 1 && severity > 1)
		amount = round(amount/2)
		depth = max(1, depth-amount)
		severity = max(1, severity-amount)
	else if(depth > 1)
		depth = max(1, depth-amount)
	else if(severity > 1)
		severity = max(1, severity-amount)
	else
		QDel(src)
		return

	if(severity < 3 && depth < 3 && bleed_amount)
		bleed_amount = 0

/datum/wound/Destroy()
	owner.wounds -= src
	owner = null
	. = ..()