/mob/human/resolve_physical_attack(var/mob/attacker, var/attack_weight, var/attack_sharpness, var/attack_contact_size, var/obj/item/attacked_with)

	var/obj/item/limb/limb = limbs[pick(limbs)]

	var/wound_depth = (attack_sharpness * attack_weight) / attack_contact_size
	var/wound_severity = (attack_weight * attack_contact_size)
	var/wound_type = (attack_sharpness > 5) ? WOUND_CUT : WOUND_BRUISE

	var/list/matching_wounds = list()
	for(var/data/wound/old_wound in limb.wounds)
		if(old_wound.wound_type == wound_type)
			matching_wounds += old_wound

	var/data/wound/wound
	if(matching_wounds.len)
		wound = pick(matching_wounds)
		wound.depth = max(wound.depth, wound_depth)
		wound.severity += wound.severity
		if(attacked_with)
			wound.left_by = attacked_with.name
		notify("The attack worsens an old wound on your [limb.name], leaving it with [wound.get_descriptor()]!")
	else
		wound = new(wound_type, wound_depth, wound_severity, attacked_with ? attacked_with.name : "unknown")
		limb.wounds += wound
		notify("The attack leaves your [limb.name] with [wound.get_descriptor()]!")
