/mob
	var/combat_cooldown = 0

/mob/proc/set_combat_cooldown(var/value)
	combat_cooldown = world.time+value

/mob/proc/on_combat_cooldown()
	return (world.time < combat_cooldown)

/mob/proc/resolve_physical_attack(var/mob/attacker, var/attack_weight, var/attack_sharpness, var/attack_contact_size, var/obj/item/attacked_with)
	if(!limbs || !limbs.len)
		return // Ghosts, new players.
	var/target_limb
	if(attacker && limbs[attacker.target_zone.selecting])
		target_limb = attacker.target_zone.selecting
	else
		target_limb = pick(limbs)
	var/obj/item/limb/limb = limbs[target_limb]
	limb.handle_attacked(attack_weight, attack_sharpness, attack_contact_size, attacked_with)
