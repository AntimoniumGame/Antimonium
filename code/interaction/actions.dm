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

/mob/proc/HandleImpact(var/mob/attacker, var/obj/item/hitby, var/meters_per_second)

	if(!istype(hitby) || !hitby.material || !limbs_by_key || !limbs_by_key.len)
		return // Ghosts, new players.

	var/target_limb
	if(attacker && GetLimb(attacker.target_zone.selecting))
		target_limb = attacker.target_zone.selecting
	else
		target_limb = pick(limbs_by_key)

	var/obj/item/limb/limb = GetLimb(target_limb)
	if(!limb) return

	var/impact_force = (0.5 * hitby.GetMass() * (meters_per_second * meters_per_second))
	var/force = impact_force

	if(CheckCoverage(limb.limb_id))
		for(var/thing in coverage_by_bodypart[limb.limb_id])

			var/obj/item/clothing/clothes = thing
			var/penetration = force/max(1,(clothes.material.GetTensileStrength() * (hitby.GetContactArea() * 0.01)))

			var/required_depth = clothes.GetThickness()
			if(penetration > required_depth)
				var/last_force = force
				force -= force * (required_depth/penetration)
				NotifyNearby("Hit from [hitby] penetrated [required_depth]cm [clothes.material.general_name] (max [penetration]cm) with force [last_force], [force] remaining")
			else
				NotifyNearby("Hit from [hitby] was stopped by [required_depth]cm [clothes.material.general_name]")
				force = 0

	if(force)
		var/penetration = force/(limb.material.GetTensileStrength() * (hitby.GetContactArea() * 0.01))
		var/wound_type = (hitby.edged && penetration) ? WOUND_CUT : WOUND_BRUISE
		NotifyNearby("Wound is [penetration]cm deep ([wound_type]), general severity is [(hitby.GetContactArea()/10) * penetration].")
		limb.HandleAttacked(attacker, hitby, penetration, wound_type)

/mob/proc/ResolveBurn(var/severity)
	if(!limbs || !limbs.len)
		return // Ghosts, new players.
	var/obj/item/limb/limb = pick(limbs)
	limb.ExpandWoundOfType(WOUND_BURN, 0, severity)
