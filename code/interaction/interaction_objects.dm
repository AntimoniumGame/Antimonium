/obj/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	HandleClickedOn(clicker, slot)

/obj/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	HandleClickedOn(clicker, slot)

/obj/proc/HandleClickedOn(var/mob/clicker, var/slot)

	if(clicker.OnActionCooldown())
		return

	if(IsAdjacentTo(src, clicker))
		if(clicker.GetEquipped(slot))
			if(AttackedBy(clicker, clicker.GetEquipped(slot)))
				clicker.SetActionCooldown(3)
		else
			if(ManipulatedBy(clicker, slot))
				clicker.SetActionCooldown(3)

/obj/item/ManipulatedBy(var/mob/user, var/slot)

	. = ..()
	if(!. && IsAdjacentTo(src, user) && !user.GetEquipped(slot))

		if(!IsSolid())
			user.Notify("<span class='warning'>You attempt to collect \the [src], but it slips through your grasp.</span>")
			user.SetActionCooldown(3)
			return TRUE

		var/obj/ui/inv/inv_slot = user.inventory_slots[slot]
		if(user.CollectItem(src, slot))
			PlayLocalSound(src, collect_sound, 50)
			NotifyNearby("<span class='notice'>\The [user] picks up \the [src] in [user.Their()] [inv_slot.unmodified_name].</span>")
			user.SetActionCooldown(3)
			return TRUE

/obj/item/proc/Attacking(var/mob/user, var/mob/target)
	if(!(flags & FLAG_SIMULATED))
		return

	if(user.intent.selecting == INTENT_HELP && target.DoSurgery(user, src))
		return TRUE

	user.DoAttackAnimation(target, src)
	user.SetActionCooldown(5)

	if(user.intent.selecting == INTENT_HELP)
		PlayLocalSound(src, 'sounds/effects/punch1.ogg', 20)
		user.NotifyNearby("<span class='warning'>\The [user] prods \the [target] with \the [src].</span>")
	else
		user.NotifyNearby("<span class='danger'>\The [user] [pick(attack_verbs)] \the [target] with \the [src]!</span>")
		PlayLocalSound(src, 'sounds/effects/whoosh1.ogg', 50)
		spawn(3)
			PlayLocalSound(src, hit_sound, 50)
		if(weight || sharpness)
			target.ResolvePhysicalAttack(user, weight, sharpness, contact_size, src)
	return TRUE

/obj/item/proc/AttackingSelf(var/mob/user)
	return

/obj/item/proc/BeforeDropped()
	return

/obj/item/proc/AfterDropped(var/mob/dropper)
	return

/obj/item/proc/BeforePickedUp(var/mob/user, var/slot)
	if(Burn(user, SLOT_HANDS))
		user.Notify("<span class='warning'>\The [src] is far too hot to handle!</span>")
		return FALSE
	return TRUE

/obj/item/proc/AfterPickedUp(var/mob/grabber)
	ResetPosition()

/obj/item/proc/AfterRemoved(var/mob/user, var/slot)
	if(slot == SLOT_HANDS)
		user.UpdateGrasp()

/obj/item/proc/BeforeRemoved(var/mob/user, var/slot)
	return TRUE
