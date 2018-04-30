/mob/proc/LeftClickOn(var/atom/thing, var/ctrl, var/alt)
	if(!TryGeneralInteraction(thing, ctrl, alt, SLOT_MOUTH, BP_HEAD))
		thing.LeftClickedOn(src, SLOT_MOUTH)

/mob/proc/RightClickOn(var/atom/thing, var/ctrl, var/alt)
	if(!TryGeneralInteraction(thing, ctrl, alt, SLOT_MOUTH, BP_HEAD))
		thing.RightClickedOn(src, SLOT_MOUTH)

/mob/proc/MiddleClickOn(var/atom/thing, var/ctrl, var/alt)
	if(!dead)
		FaceAtom(thing)
		thing.MiddleClickedOn(src)

/mob/human/LeftClickOn(var/atom/thing, var/ctrl, var/alt)
	if(!Incapacitated() && !TryGeneralInteraction(thing, ctrl, alt, SLOT_LEFT_HAND, BP_LEFT_HAND) && thing)
		thing.LeftClickedOn(src, SLOT_LEFT_HAND)

/mob/human/RightClickOn(var/atom/thing, var/ctrl, var/alt)
	if(!Incapacitated() && !TryGeneralInteraction(thing, ctrl, alt, SLOT_RIGHT_HAND, BP_RIGHT_HAND) && thing)
		thing.RightClickedOn(src, SLOT_RIGHT_HAND)

/mob/proc/TryGeneralInteraction(var/atom/thing, var/ctrl, var/alt, var/slot, var/limb)
	if(!Incapacitated() && CanUseLimb(limb))
		FaceAtom(thing)
		if(ctrl && thing.IsGrabbable() && thing != src)
			GrabAtom(thing, limb, slot)
			return TRUE

		var/obj/item/limb/use_limb = GetLimb(limb)
		if(use_limb.IsDextrous(TRUE))
			if(alt && (istype(thing, /turf) || istype(thing.loc, /turf)))
				var/obj/item/throwing = GetEquipped(slot)
				if(throwing && throwing.ThrowAt(src, thing))
					return TRUE
			else
				var/obj/item/firing = GetEquipped(slot)
				if(istype(firing) && firing.FireAt(src, thing))
					return TRUE

	return FALSE

/mob/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	HandleInteraction(clicker, slot)

/mob/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	HandleInteraction(clicker, slot)

/mob/proc/HandleInteraction(var/mob/person, var/slot_id)

	if(person.OnActionCooldown() || !IsAdjacentTo(src, person))
		return

	var/obj/item/prop = person.GetEquipped(slot_id)
	if(prop)
		if(AttackedBy(person, prop))
			person.SetActionCooldown(6)
	else
		if(ManipulatedBy(person))
			person.SetActionCooldown(4)

/mob/ManipulatedBy(var/mob/user, var/slot)
	. = ..()
	if(!.)
		user.DoAttackAnimation(src)
		if(user.intent.selecting == INTENT_HELP)
			user.DoPassiveUnarmedInteraction(src)
		else
			user.DoViolentUnarmedInteraction(src)
		return TRUE

/mob/AttackedBy(var/mob/user, var/obj/item/prop)
	. = ..()
	if(!.)
		prop.Attacking(user, src)
		return TRUE

/mob/proc/DoViolentUnarmedInteraction(var/mob/target)
	if(!unarmed_attack) return
	NotifyNearby("\The [src] [pick(unarmed_attack.attack_verbs)] \the [target] with [Their()] [unarmed_attack.name]!", MESSAGE_VISIBLE)
	PlayLocalSound(src, 'sounds/effects/punch1.ogg', 50)
	target.HandleImpact(src, unarmed_attack, unarmed_attack.attack_force)

/mob/proc/DoPassiveUnarmedInteraction(var/mob/target)
	NotifyNearby("\The [src] pokes \the [target].", MESSAGE_VISIBLE)
