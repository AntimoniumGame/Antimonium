/mob/human
	var/list/active_grabs = list()

/mob/human/resolve_physical_attack(var/mob/attacker, var/attack_weight, var/attack_sharpness, var/attack_contact_size, var/obj/item/attacked_with)
	var/obj/item/limb/limb = limbs[pick(limbs)]
	limb.handle_attacked(attacker, attack_weight, attack_sharpness, attack_contact_size, attacked_with)
