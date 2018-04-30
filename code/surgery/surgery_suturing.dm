/datum/surgery/suturing
	name = "Suture Wound"
	tools = list(/obj/item/needle = 80)

/datum/surgery/suturing/CanPerformOn(var/mob/surgeon, var/mob/patient)
	var/obj/item/limb/limb = patient.limbs_by_key[surgeon.target_zone.selecting]
	if(istype(limb))
		for(var/thing in limb.wounds)
			var/datum/wound/wound = thing
			if(!wound.Bandaged() && wound.wound_type == WOUND_CUT && wound.size >= SUTURE_THRESHOLD)
				return TRUE
	return FALSE

/datum/surgery/suturing/CanPerformWith(var/atom/movable/tool)
	. = ..()
	if(.)
		var/obj/item/needle/needle = tool
		if(!needle.threaded)
			return FALSE

/datum/surgery/suturing/Begin(var/mob/surgeon, var/mob/patient, var/atom/movable/instrument)
	var/obj/item/limb/limb = patient.limbs_by_key[surgeon.target_zone.selecting]
	if(istype(limb))
		surgeon.NotifyNearby("<span class = 'notice'>\The [surgeon] begins suturing a wound on \the [patient]'s [limb.name].</span>", MESSAGE_VISIBLE)

/datum/surgery/suturing/End(var/mob/surgeon, var/mob/patient, var/atom/movable/instrument)
	var/obj/item/limb/limb = patient.limbs_by_key[surgeon.target_zone.selecting]
	if(istype(limb))
		surgeon.NotifyNearby("<span class = 'notice'>\The [surgeon] finishes placing some sutures in \the [patient]'s [limb.name].</span>", MESSAGE_VISIBLE)
		for(var/thing in limb.wounds)
			var/datum/wound/wound = thing
			if(!wound.Bandaged() && wound.wound_type == WOUND_CUT && wound.size >= SUTURE_THRESHOLD)
				wound.size = max(0, wound.size - rand(5,10))
				if(wound.size < 3 && wound.depth < 3 && wound.bleed_amount)
					wound.bleed_amount = 0
	var/obj/item/needle/needle = instrument
	if(istype(needle)) needle.ConsumeThread(1)

/datum/surgery/suturing/Fail(var/mob/surgeon, var/mob/patient, var/atom/movable/instrument)
	var/obj/item/limb/limb = patient.limbs_by_key[surgeon.target_zone.selecting]
	if(istype(limb))
		surgeon.NotifyNearby("<span class = 'danger'>\The [surgeon] fails to suture \the [patient]'s [limb.name]!</span>", MESSAGE_VISIBLE)
	var/obj/item/needle/needle = instrument
	if(istype(needle)) needle.ConsumeThread(1)
