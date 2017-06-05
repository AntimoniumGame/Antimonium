/mob/proc/LeftClickOn(var/atom/thing, var/ctrl, var/alt)
	if(!TryGeneralInteraction(thing, ctrl, alt, SLOT_MOUTH, BP_HEAD))
		thing.LeftClickedOn(src, SLOT_MOUTH)

/mob/proc/RightClickOn(var/atom/thing, var/ctrl, var/alt)
	if(!TryGeneralInteraction(thing, ctrl, alt, SLOT_MOUTH, BP_HEAD))
		thing.LeftClickedOn(src, SLOT_MOUTH)

/mob/proc/MiddleClickOn(var/atom/thing, var/ctrl, var/alt)
	if(!dead)
		FaceAtom(thing)
		thing.MiddleClickedOn(src)

/mob/human/LeftClickOn(var/atom/thing, var/ctrl, var/alt)
	if(!TryGeneralInteraction(thing, ctrl, alt, SLOT_LEFT_HAND, BP_LEFT_HAND))
		thing.LeftClickedOn(src, SLOT_LEFT_HAND)

/mob/human/RightClickOn(var/atom/thing, var/ctrl, var/alt)
	if(!TryGeneralInteraction(thing, ctrl, alt, SLOT_RIGHT_HAND, BP_RIGHT_HAND))
		thing.RightClickedOn(src, SLOT_RIGHT_HAND)

/mob/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	HandleInteraction(clicker, slot)

/mob/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	HandleInteraction(clicker, slot)

/mob/proc/HandleInteraction(var/mob/person, var/slot_id)
	if(!IsAdjacentTo(src, person))
		return
	if(person == src)
		HandleInteractionSelf(slot_id)
	else
		HandleInteractionOther(person, slot_id)

/mob/proc/HandleInteractionOther(var/mob/person, var/slot_id)
	if(OnActionCooldown())
		return
	var/obj/item/prop = person.GetEquipped(slot_id)
	if(prop)
		if(prop.Attacking(person, src))
			SetActionCooldown(6)
	else
		if(person.Attack(src))
			SetActionCooldown(4)

/mob/proc/HandleInteractionSelf(var/slot_id)
	if(OnActionCooldown())
		return
	SetActionCooldown(2)
	var/obj/item/prop = GetEquipped(slot_id)
	if(prop)
		prop.AttackingSelf(src)
	else
		AttackSelf()

/mob/proc/AttackSelf()
	return

/mob/proc/Attack(var/mob/target)
	if(OnActionCooldown())
		return
	SetActionCooldown(3)
	DoUnarmedAttack(target)

/mob/proc/DoUnarmedAttack(var/mob/target)
	if(OnActionCooldown())
		return
	SetActionCooldown(3)
	DoAttackAnimation(target)
	if(intent.selecting == INTENT_HELP)
		DoPassiveUnarmedInteraction(target)
	else
		DoViolentUnarmedInteraction(target)

/mob/proc/DoViolentUnarmedInteraction(var/mob/target)
	NotifyNearby("\The [src] punches \the [target]!")
	PlayLocalSound(src, 'sounds/effects/punch1.ogg', 50)
	target.ResolvePhysicalAttack(src, 5, 0, 5, null)

/mob/proc/DoPassiveUnarmedInteraction(var/mob/target)
	NotifyNearby("\The [src] pokes \the [target].")

/mob/proc/TryGeneralInteraction(var/atom/thing, var/ctrl, var/alt, var/slot, var/limb)
	if(!dead && CanUseLimb(limb))
		FaceAtom(thing)
		if(ctrl && thing.IsGrabbable() && thing != src)
			GrabAtom(thing, limb, slot)
			return TRUE
		else if(alt && (istype(thing, /turf) || istype(thing.loc, /turf)))
			var/obj/item/limb/use_limb = limbs[limb]
			if(!use_limb.IsDextrous())
				return TRUE
			var/obj/item/throwing = GetEquipped(slot)
			if(throwing && throwing.ThrowAt(src, thing))
				return TRUE
	return FALSE
