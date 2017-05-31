#define HEAL_PER_TICK 4

/obj/item/limb
	var/cumulative_wound_depth = 0
	var/cumulative_wound_severity = 0

/obj/item/limb/Process() // These are processed in human life, they don't need to be on the items list.

	if(!NeedProcess())
		owner.injured_limbs -= src
		return

	if(broken)
		HandleBreakEffects()

	if(!wounds.len)
		if(broken)
			AdjustPain(1)
		else if(pain)
			AdjustPain(-1)
	else

		cumulative_wound_depth = 0
		cumulative_wound_severity = 0
		var/bleeding = FALSE

		for(var/thing in wounds)

			var/datum/wound/wound = thing
			cumulative_wound_severity += wound.severity
			cumulative_wound_depth += wound.depth

			if(wound.Bleed())
				bleeding = TRUE
			wound.AttemptRegeneration(HEAL_PER_TICK)

		if(pain < max(cumulative_wound_depth, cumulative_wound_severity))
			AdjustPain(1)
		else if(!broken && !bleeding)
			AdjustPain(-1)

	ShowPain()
	UpdateLimbState()

/obj/item/limb/proc/NeedProcess()
	return ((wounds.len > 0) || pain || broken)

/obj/item/limb/proc/UpdateLimbState()
	if(!owner)
		return
	if(cumulative_wound_depth > 30 && cumulative_wound_severity > 50)
		SeverLimb()
		return
	if(cumulative_wound_severity > 50 && !broken)
		BreakBone()

/obj/item/limb/proc/RemoveOwnerBlood(var/amount)
	if(owner.blood)
		if(prob(amount*5))
			Splatter(loc, owner.blood_material)
		owner.blood = min(100, max(0, owner.blood - amount))

#undef HEAL_PER_TICK
