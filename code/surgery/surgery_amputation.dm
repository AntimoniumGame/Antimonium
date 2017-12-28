/datum/surgery/amputation
	name = "Amputate Limb"
	tools = list(/obj/item/weapon/handsaw = 80)

/datum/surgery/amputation/CanPerformOn(var/mob/surgeon, var/mob/patient)
	var/obj/item/limb/limb = patient.limbs_by_key[surgeon.target_zone.selecting]
	return (..() && istype(limb) && !limb.root_limb)

/datum/surgery/amputation/Begin(var/mob/surgeon, var/mob/patient, var/atom/movable/instrument)
	var/obj/item/limb/limb = patient.limbs_by_key[surgeon.target_zone.selecting]
	if(istype(limb))
		surgeon.NotifyNearby("<span class = 'notice'>\The [surgeon] begins sawing through \the [patient]'s [limb.name].</span>", MESSAGE_VISIBLE)

/datum/surgery/amputation/End(var/mob/surgeon, var/mob/patient, var/atom/movable/instrument)
	var/obj/item/limb/limb = patient.limbs_by_key[surgeon.target_zone.selecting]
	if(istype(limb))
		surgeon.NotifyNearby("<span class = 'notice'>\The [surgeon] finishes amputating \the [patient]'s [limb.name].</span>", MESSAGE_VISIBLE)
		limb.SeverLimb(amputated = TRUE)

/datum/surgery/amputation/Fail(var/mob/surgeon, var/mob/patient, var/atom/movable/instrument)
	var/obj/item/limb/limb = patient.limbs_by_key[surgeon.target_zone.selecting]
	if(istype(limb))
		surgeon.NotifyNearby("<span class = 'danger'>\The [surgeon] fails to cleanly amputate \the [patient]'s [limb.name]!</span>", MESSAGE_VISIBLE)
		limb.SeverLimb()
