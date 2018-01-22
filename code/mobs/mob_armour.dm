/mob
	var/list/armour_by_bodypart

/mob/New()
	..()
	armour_by_bodypart = list()
	appearance_flags |= NO_CLIENT_COLOR

/mob/proc/CheckArmourCoverage(var/bodypart = BP_CHEST, var/coverage_type = WOUND_CUT, var/threshold = 0)

	if(!length(armour_by_bodypart[bodypart]))
		return FALSE

	var/total = 0
	for(var/thing in armour_by_bodypart[bodypart])
		var/obj/item/clothing/armour = thing
		total += armour.armour[coverage_type]
		if(total >= threshold)
			return TRUE
	return FALSE

/mob/proc/RemoveArmourCoverage(var/obj/item/clothing/armour)
	if(istype(armour) && length(armour.body_coverage))
		for(var/bodypart in armour.body_coverage)
			if(armour_by_bodypart[bodypart]) armour_by_bodypart[bodypart] -= armour

/mob/proc/AddArmourCoverage(var/obj/item/clothing/armour)
	if(istype(armour) && length(armour.body_coverage))
		for(var/bodypart in armour.body_coverage)
			if(!armour_by_bodypart[bodypart])
				armour_by_bodypart[bodypart] = list()
			armour_by_bodypart[bodypart] += armour

/mob/proc/HandleArmour(var/obj/item/limb/limb, var/attack_weight, var/attack_sharpness, var/attack_contact_size)

	var/wound_depth = max(1,round((attack_sharpness * attack_weight) / max(1,attack_contact_size)))
	var/wound_severity = (attack_weight * attack_contact_size)
	var/wound_type = (attack_sharpness > 1) ? WOUND_CUT : WOUND_BRUISE

	if(!CheckArmourCoverage(limb.limb_id))
		return list(wound_depth, wound_severity, wound_type)

	for(var/thing in armour_by_bodypart[limb.limb_id])
		var/obj/item/clothing/clothes = thing
		var/armour_val = clothes.armour[wound_type]
		if(armour_val > 0)
			wound_severity -= armour_val
			wound_depth -= armour_val
		clothes.TakeDamage(wound_severity, "battle damage")
		if(wound_severity <= 0 && wound_depth <= 0)
			break

	return list(wound_depth, wound_severity, wound_type)
