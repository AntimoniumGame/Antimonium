/obj/item/limb
	var/list/wounds = list()
	var/broken = FALSE

/obj/item/limb/proc/HandleAttacked(var/attack_weight, var/attack_sharpness, var/attack_contact_size, var/obj/item/attacked_with)

	if(!owner)
		return

	var/wound_depth = (attack_sharpness * attack_weight) / max(1,attack_contact_size)
	var/wound_severity = (attack_weight * attack_contact_size)
	var/wound_type = (attack_sharpness > 1) ? WOUND_CUT : WOUND_BRUISE

	cumulative_wound_depth += wound_depth
	cumulative_wound_severity += wound_severity
	owner.injured_limbs |= src

	if(wound_type == WOUND_CUT && wound_severity > 5)
		Splatter(owner, get_turf(owner), /datum/material/water/blood)

	if(wounds.len)
		var/list/matching_wounds = list()
		for(var/datum/wound/old_wound in wounds)
			if(old_wound.wound_type == wound_type)
				matching_wounds += old_wound
		if(matching_wounds.len)
			var/datum/wound/wound = pick(matching_wounds)
			wound.depth += wound_depth
			wound.severity += wound_severity
			if(attacked_with)
				wound.left_by = attacked_with.name
			owner.Notify("<b>A wound on your [name] worsens into [wound.GetDescriptor()]!</b>")
			SetPain(max(pain, wound.severity))
			UpdateLimbState()
			return

	var/datum/wound/wound = new(src, wound_type, wound_depth, wound_severity, attacked_with ? attacked_with.name : "unknown")
	wounds += wound
	SetPain(max(pain, wound.severity))
	owner.Notify("<b>The blow leaves your [name] with [wound.GetDescriptor()]!</b>")
	UpdateLimbState()

/obj/item/limb/proc/BreakBone()
	owner.NotifyNearby("<b>\The [owner]'s [name] makes a horrible cracking sound!</b>")
	broken = TRUE
	HandleBreakEffects()

/obj/item/limb/proc/SeverLimb(var/obj/item/limb/severing)

	if(!owner || root_limb)
		return

	not_moving = FALSE
	owner.injured_limbs -= src
	owner.limbs[limb_id] = null
	owner.limbs -= limb_id

	if(severing)
		ForceMove(severing)
		for(var/obj/item/limb/child in children)
			child.SeverLimb(severing)
	else
		for(var/obj/item/limb/child in children)
			child.SeverLimb(src)
		if(parent)
			var/datum/wound/wound = new(parent, WOUND_CUT, 20, 40, "traumatic amputation")
			parent.wounds += wound
			parent.cumulative_wound_depth += wound.depth
			parent.cumulative_wound_severity += wound.severity
			owner.injured_limbs |= parent
			parent.children -= src
			parent = null

		PlayLocalSound(src, pick(list('sounds/effects/gore1.ogg','sounds/effects/gore2.ogg','sounds/effects/gore3.ogg')), 100)
		owner.NotifyNearby("<b>\The [owner]'s [name] flies off in an arc!</b>")
		var/matrix/M = matrix()
		M.Turn(pick(0,90,180,270))
		transform = M
		ThrownAt(get_step(src, pick(all_dirs)))
		Splatter(owner, loc, /datum/material/water/blood)

		owner.UpdateIcon()
		for(var/obj/item/limb/child in src)
			overlays += child.GetWornIcon("world")

	HandleSeverEffects()
	owner = null

/obj/item/limb/proc/HandleSeverEffects()
	if(vital)
		owner.Die("loss of a vital organ")

/obj/item/limb/proc/HandleBreakEffects()
	return