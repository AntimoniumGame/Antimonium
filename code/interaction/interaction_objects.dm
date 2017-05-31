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

/obj/AttackedBy(var/mob/user, var/obj/item/prop)
	if(IsFlammable() && prop.IsFlammable())
		if(!prop.IsOnFire() && IsOnFire())
			user.NotifyNearby("\The [user] lights \the [prop] in \the [src].")
			prop.Ignite(user)
			return TRUE
		else if(prop.IsOnFire() && !IsOnFire())
			user.NotifyNearby("\The [user] lights \the [src] with \the [prop].")
			Ignite(user)
			return TRUE
	return FALSE

/obj/proc/ManipulatedBy(var/mob/user, var/slot)
	if(IsOnFire() && user.intent.selecting == INTENT_HELP)
		NotifyNearby("\The [user] extinguishes \the [src].")
		Extinguish()
		return TRUE
	if((flags & FLAG_SEATING) && !user.sitting && !user.prone && user.Move(loc))
		user.SetDir(dir)
		user.ToggleSitting()
		return TRUE
	return FALSE

/obj/item/HandleClickedOn(var/mob/clicker, var/slot)
	if(IsAdjacentTo(get_turf(src), get_turf(clicker)) && !clicker.GetEquipped(slot))

		if(!IsSolid())
			NotifyNearby("\The [clicker] attempts to collect \the [src], but it slips through [clicker.Their()] grasp.")
			return

		var/obj/ui/inv/inv_slot = clicker.inventory_slots[slot]
		if(clicker.CollectItem(src, slot))
			PlayLocalSound(src, collect_sound, 50)
			NotifyNearby("\The [clicker] picks up \the [src] in [clicker.Their()] [inv_slot.unmodified_name].")
		return
	. = ..()

/obj/item/proc/Attacking(var/mob/user, var/mob/target)
	if(!(flags & FLAG_SIMULATED))
		return
	user.DoAttackAnimation(target, src)
	if(user.intent.selecting == INTENT_HELP)
		PlayLocalSound(src, 'sounds/effects/punch1.ogg', 20)
		user.NotifyNearby("\The [user] prods \the [target] with \the [src].")
	else
		user.NotifyNearby("\The [user] [pick(attack_verbs)] \the [target] with \the [src]!")
		PlayLocalSound(src, 'sounds/effects/whoosh1.ogg', 50)
		spawn(3)
			PlayLocalSound(src, hit_sound, 50)
		if(weight || sharpness)
			target.ResolvePhysicalAttack(user, weight, sharpness, contact_size, src)

/obj/item/proc/AttackingSelf(var/mob/user)
	return

/obj/item/proc/BeforeDropped()
	return

/obj/item/proc/AfterDropped()
	return

/obj/item/proc/BeforePickedUp(var/mob/user, var/slot)
	if(Burn(user, SLOT_HANDS))
		user.Notify("\The [src] is far too hot to handle!")
		return FALSE
	return TRUE

/obj/item/proc/AfterPickedUp()
	ResetPosition()

/obj/item/proc/ResetPosition()
	pixel_x = initial(pixel_x)
	pixel_y = initial(pixel_y)
	transform = null

/obj/item/proc/AfterRemoved(var/mob/user, var/slot)
	if(slot == SLOT_HANDS)
		user.UpdateGrasp()

/obj/item/proc/BeforeRemoved(var/mob/user, var/slot)
	return TRUE