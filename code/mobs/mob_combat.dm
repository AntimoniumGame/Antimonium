/mob
	var/combat_cooldown = 0

/mob/proc/set_combat_cooldown(var/value)
	combat_cooldown = world.time+value

/mob/proc/on_combat_cooldown()
	return (world.time < combat_cooldown)

/mob/proc/resolve_physical_attack(var/mob/attacker, var/attack_weight, var/attack_sharpness, var/attack_contact_size, var/obj/item/attacked_with)
	return
