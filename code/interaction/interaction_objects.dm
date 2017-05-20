/obj/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	HandleClickedOn(clicker, slot)

/obj/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	HandleClickedOn(clicker, slot)

/obj/proc/HandleClickedOn(var/mob/clicker, var/slot)
	if(IsAdjacentTo(get_turf(src), get_turf(clicker)))
		if(clicker.GetEquipped(slot))
			AttackedBy(clicker, clicker.GetEquipped(slot))
		else
			ManipulatedBy(clicker, slot)

/obj/proc/AttackedBy(var/mob/user, var/obj/item/thing)
	return

/obj/proc/ManipulatedBy(var/mob/user, var/slot)
	return

/obj/item/HandleClickedOn(var/mob/clicker, var/slot)
	if(IsAdjacentTo(get_turf(src), get_turf(clicker)) && !clicker.GetEquipped(slot))

		if(!IsSolid())
			NotifyNearby("\The [clicker] attempts to collect \the [src], but it slips through [clicker.Their()] grasp.")
			return

		var/obj/ui/inv/inv_slot = clicker.inventory_slots[slot]
		NotifyNearby("\The [clicker] picks up \the [src] in [clicker.Their()] [inv_slot.name].")
		PlayLocalSound(src, collect_sound, 50)
		clicker.CollectItem(src, slot)
		return
	. = ..()

/obj/item/proc/Attacking(var/mob/user, var/mob/target)
	if(!(flags & FLAG_SIMULATED))
		return
	user.DoAttackAnimation(target, src)
	if(user.intent.selecting == INTENT_HELP)
		PlayLocalSound(src, 'sounds/effects/punch1.wav', 20)
		user.NotifyNearby("\The [user] prods \the [target] with \the [src].")
	else
		user.NotifyNearby("\The [user] [pick(attack_verbs)] \the [target] with \the [src]!")
		PlayLocalSound(src, 'sounds/effects/whoosh1.wav', 50)
		spawn(3)
			PlayLocalSound(src, hit_sound, 50)
		if(weight || sharpness)
			target.ResolvePhysicalAttack(user, weight, sharpness, contact_size, src)

/obj/item/proc/AttackingSelf(var/mob/user)
	return

/obj/item/AttackedBy(var/mob/user, var/obj/item/thing)
	return

/obj/item/proc/BeforeDropped()
	return

/obj/item/proc/AfterDropped()
	return

/obj/item/proc/BeforePickedUp()
	return

/obj/item/proc/AfterPickedUp()
	ResetPosition()

/obj/item/proc/ResetPosition()
	pixel_x = initial(pixel_x)
	pixel_y = initial(pixel_y)
	transform = null
