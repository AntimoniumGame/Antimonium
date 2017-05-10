#define HEAL_PER_TICK 4

/obj/item/limb
	var/cumulative_wound_depth = 0
	var/cumulative_wound_severity = 0

/obj/item/limb/process() // These are processed in human life, they don't need to be on the items list.

	if(!need_process())
		owner.injured_limbs -= src
		return

	if(broken)
		handle_break_effects()

	if(!wounds.len)
		if(broken)
			adjust_pain(1)
		else if(pain)
			adjust_pain(-1)
	else

		cumulative_wound_depth = 0
		cumulative_wound_severity = 0
		var/bleeding = FALSE

		for(var/thing in wounds)

			var/data/wound/wound = thing
			cumulative_wound_severity += wound.severity
			cumulative_wound_depth += wound.depth

			if(wound.bleed())
				bleeding = TRUE
			wound.attempt_regeneration(HEAL_PER_TICK)

		if(pain < max(cumulative_wound_depth, cumulative_wound_severity))
			adjust_pain(1)
		else if(!broken && !bleeding)
			adjust_pain(-1)

	show_pain()
	update_limb_state()

/obj/item/limb/proc/need_process()
	return ((wounds.len > 0) || pain || broken)

/obj/item/limb/proc/update_limb_state()
	if(!owner)
		return
	if(cumulative_wound_depth > 30 && cumulative_wound_severity > 50)
		sever_limb()
		return
	if(cumulative_wound_severity > 50 && !broken)
		break_bone()

/obj/item/limb/proc/remove_owner_blood(var/amount)
	if(owner.blood)
		blood_splatter(owner, loc)
		owner.blood = min(100, max(0, owner.blood - amount))

#undef HEAL_PER_TICK
