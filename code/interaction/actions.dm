/mob
	var/combat_cooldown = 0
	var/obj/ui/cooldown_indicator

/mob/CreateUI()
	cooldown_indicator = new(src)
	cooldown_indicator.alpha = 0
	cooldown_indicator.mouse_opacity = 0
	cooldown_indicator.icon = 'icons/images/ui_cooldown.dmi'
	cooldown_indicator.screen_loc = "4,1"
	cooldown_indicator.layer += 0.5
	. = ..()

/mob/proc/SetActionCooldown(var/value)
	combat_cooldown = max(combat_cooldown, world.time+value)
	cooldown_indicator.alpha = 128
	animate(cooldown_indicator) // Kill previous anim.
	animate(cooldown_indicator, alpha = 0, time = value)

/mob/proc/OnActionCooldown()
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
