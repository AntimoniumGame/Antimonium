/mob
	var/combat_cooldown = 0

/mob/proc/SetCombatCooldown(var/value)
	combat_cooldown = world.time+value

/mob/proc/OnCombatCooldown()
	return (world.time < combat_cooldown)

/mob/proc/ResolvePhysicalAttack(var/mob/attacker, var/attack_weight, var/attack_sharpness, var/attack_contact_size, var/obj/item/attacked_with)
	if(!limbs || !limbs.len)
		return // Ghosts, new players.
	var/target_limb
	if(attacker && limbs[attacker.target_zone.selecting])
		target_limb = attacker.target_zone.selecting
	else
		target_limb = pick(limbs)
	var/obj/item/limb/limb = limbs[target_limb]
	limb.HandleAttacked(attack_weight, attack_sharpness, attack_contact_size, attacked_with)
