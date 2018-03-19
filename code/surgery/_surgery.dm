/proc/InitializeSurgerySteps()
	for(var/stype in typesof(/datum/surgery)-/datum/surgery)
		_glob.surgery_steps += GetUniqueDataByPath(stype)

/datum/surgery
	var/name = "Generic Surgery"
	var/delay = 30
	var/list/tools = list()

/datum/surgery/proc/CanPerformBy(var/mob/user)
	return TRUE

/datum/surgery/proc/CanPerformWith(var/atom/movable/tool)
	for(var/tool_type in tools)
		if(istype(tool, tool_type))
			return tools[tool_type]
	return FALSE

/datum/surgery/proc/CanPerformOn(var/mob/surgeon, var/mob/patient)
	return (!surgeon.prone && (patient.prone || patient.sitting))

/datum/surgery/proc/Begin(var/mob/surgeon, var/mob/patient, var/atom/movable/instrument)
	return TRUE

/datum/surgery/proc/End(var/mob/surgeon, var/mob/patient, var/atom/movable/instrument)
	return TRUE

/datum/surgery/proc/Fail(var/mob/surgeon, var/mob/patient, var/atom/movable/instrument)
	return TRUE

/mob/proc/DoSurgery(var/mob/user, var/obj/item/prop)
	if(!IsAdjacentTo(user, src))
		return FALSE

	//TODO faster surgery step lookup
	for(var/thing in _glob.surgery_steps)
		var/datum/surgery/surgery = thing
		var/surgery_chance = surgery.CanPerformWith(prop)
		if(surgery_chance > 0 && surgery.CanPerformBy(user) && surgery.CanPerformOn(user, src))
			user.SetActionCooldown(surgery.delay)
			surgery.Begin(user, src, prop)
			if(DoAfterDelay(user, src, surgery.delay, prop) && prob(surgery_chance))
				surgery.End(user, src, prop)
			else
				surgery.Fail(user, src, prop)
			return TRUE

	return FALSE