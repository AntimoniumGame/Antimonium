/data/wound/proc/bleed()
	if(wound_type == WOUND_CUT && severity > 5)
		blood_splatter(owner.owner, owner.loc)

	bleed_amount = max(0, bleed_amount--)

/data/wound/proc/bandaged()
	return FALSE

/data/wound/proc/can_regenerate()
	return (severity < 30 && (wound_type != WOUND_CUT || bandaged()))

/data/wound/proc/attempt_regeneration(var/amount)

	if(!can_regenerate())
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
		qdel(src)
		return

	if(severity < 3 && depth < 3 && bleed_amount)
		bleed_amount = 0

/data/wound/destroy()
	owner.wounds -= src
	owner = null
	. = ..()