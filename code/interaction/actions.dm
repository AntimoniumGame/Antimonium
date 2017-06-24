/mob
	var/combat_cooldown = 0
	var/obj/ui/cooldown_indicator

/mob/proc/SetActionCooldown(var/value)
	combat_cooldown = max(combat_cooldown, world.time+value)
	if(cooldown_indicator)
		cooldown_indicator.alpha = 128
		animate(cooldown_indicator) // Kill previous anim.
		animate(cooldown_indicator, alpha = 0, time = value)

/mob/proc/OnActionCooldown()
	return (world.time < combat_cooldown)

/mob/proc/ResolvePhysicalAttack(var/mob/attacker, var/attack_weight, var/attack_sharpness, var/attack_contact_size, var/obj/item/attacked_with)
	if(!limbs_by_key || !limbs_by_key.len)
		return // Ghosts, new players.
	var/target_limb
	if(attacker && GetLimb(attacker.target_zone.selecting))
		target_limb = attacker.target_zone.selecting
	else
		target_limb = pick(limbs_by_key)
	var/obj/item/limb/limb = GetLimb(target_limb)
	limb.HandleAttacked(attack_weight, attack_sharpness, attack_contact_size, attacked_with)

/mob/proc/ResolveBurn(var/attack_weight, var/attack_sharpness, var/attack_contact_size)
	if(!limbs || !limbs.len)
		return // Ghosts, new players.
	var/obj/item/limb/limb = pick(limbs)
	limb.HandleBurned(attack_weight, attack_sharpness, attack_contact_size)
