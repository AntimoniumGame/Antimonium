/obj/item/limb
	var/list/wounds = list()
	var/broken = FALSE

/obj/item/limb/proc/handle_attacked(var/mob/attacker, var/attack_weight, var/attack_sharpness, var/attack_contact_size, var/obj/item/attacked_with)

	if(!owner)
		return

	var/wound_depth = (attack_sharpness * attack_weight) / attack_contact_size
	var/wound_severity = (attack_weight * attack_contact_size)
	var/wound_type = (attack_sharpness > 1) ? WOUND_CUT : WOUND_BRUISE

	cumulative_wound_depth += wound_depth
	cumulative_wound_severity += wound_severity
	owner.injured_limbs |= src

	if(wound_type == WOUND_CUT && wound_severity > 5)
		blood_splatter(owner, get_turf(owner))

	if(wounds.len)
		var/list/matching_wounds = list()
		for(var/data/wound/old_wound in wounds)
			if(old_wound.wound_type == wound_type)
				matching_wounds += old_wound
		if(matching_wounds.len)
			var/data/wound/wound = pick(matching_wounds)
			wound.depth += wound_depth
			wound.severity += wound_severity
			if(attacked_with)
				wound.left_by = attacked_with.name
			owner.notify("<b>A wound on your [name] worsens into [wound.get_descriptor()]!</b>")
			set_pain(max(pain, wound.severity))
			update_limb_state()
			return

	var/data/wound/wound = new(src, wound_type, wound_depth, wound_severity, attacked_with ? attacked_with.name : "unknown")
	wounds += wound
	set_pain(max(pain, wound.severity))
	owner.notify("<b>The attack leaves your [name] with [wound.get_descriptor()]!</b>")
	update_limb_state()

/obj/item/limb/proc/break_bone()
	owner.notify_nearby("<b>\The [owner]'s [name] makes a horrible cracking sound!</b>")
	broken = TRUE
	handle_break_effects()

/obj/item/limb/proc/sever_limb(var/obj/item/limb/severing)

	if(!owner || root_limb)
		return

	owner.injured_limbs -= src
	owner.limbs[limb_id] = null
	owner.limbs -= limb_id

	if(severing)
		ForceMove(severing)
		for(var/obj/item/limb/child in children)
			child.sever_limb(severing)
	else
		for(var/obj/item/limb/child in children)
			child.sever_limb(src)
		if(parent)
			var/data/wound/wound = new(parent, WOUND_CUT, 20, 40, "traumatic amputation")
			parent.wounds += wound
			parent.cumulative_wound_depth += wound.depth
			parent.cumulative_wound_severity += wound.severity
			owner.injured_limbs |= parent
			parent.children -= src
			parent = null

		owner.notify_nearby("<b>\The [owner]'s [name] flies off in an arc!</b>")
		var/matrix/M = matrix()
		M.Turn(pick(0,90,180,270))
		transform = M
		ForceMove(get_turf(owner))
		step(src, pick(cardinal_dirs))
		blood_splatter(owner, loc)

		owner.update_icon()
		for(var/obj/item/limb/child in src)
			overlays += child.get_worn_icon("world")

	handle_sever_effects()
	owner = null

/obj/item/limb/proc/handle_sever_effects()
	if(vital)
		owner.die("loss of a vital organ")

/obj/item/limb/proc/handle_break_effects()
	return