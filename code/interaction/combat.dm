/mob
	var/combat_cooldown = 0

/mob/proc/set_combat_cooldown(var/value)
	combat_cooldown = world.time+value

/mob/proc/on_combat_cooldown()
	return (world.time < combat_cooldown)

/mob/proc/resolve_physical_attack(var/mob/attacker, var/attack_weight, var/attack_sharpness, var/attack_contact_size, var/obj/item/attacked_with)
	return

/mob/human/resolve_physical_attack(var/mob/attacker, var/attack_weight, var/attack_sharpness, var/attack_contact_size, var/obj/item/attacked_with)
	var/target_limb = pick(limbs)
	if(istype(attacker, /mob/human))
		var/mob/human/human_attacker = attacker
		if(limbs[human_attacker.target_zone.selecting])
			target_limb = human_attacker.target_zone.selecting
	var/obj/item/limb/limb = limbs[target_limb]
	limb.handle_attacked(attack_weight, attack_sharpness, attack_contact_size, attacked_with)
