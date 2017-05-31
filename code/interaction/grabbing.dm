/obj/item/grab
	icon = 'icons/objects/items/grab.dmi'
	var/mob/human/owner
	var/atom/movable/grabbed
	flags = 0

/obj/item/grab/New(var/mob/human/_owner, var/atom/movable/_grabbed)
	..(_owner)
	owner = _owner
	owner.active_grabs += src
	grabbed = _grabbed
	name = "grip on \the [grabbed]"
	processing_objects += src

/obj/item/grab/AfterDropped()
	QDel(src)

/obj/item/grab/Destroy()

	// I GIVE UP I'M HARDCODING THIS.
	if(owner)
		owner.active_grabs -= src
		for(var/invslot in owner.inventory_slots)
			var/obj/ui/inv/inv_slot = owner.inventory_slots[invslot]
			if(inv_slot.holding == src)
				inv_slot.ForgetHeld()
				break
		owner.UpdateIcon()

	grabbed = null
	owner = null
	processing_objects -= src
	. = ..()

/obj/item/grab/Process()
	CheckState()

/obj/item/grab/proc/CheckState()
	if(!owner || loc != owner || !isturf(owner.loc) || !grabbed || !isturf(grabbed.loc) || !IsAdjacentTo(grabbed, owner) || !grabbed.IsSolid())
		QDel(src)
		return FALSE
	return TRUE

/mob
	var/list/active_grabs = list()

/mob/proc/GrabAtom(var/atom/movable/grabbing, var/grabbing_with, var/grabbing_slot)

	if(!IsAdjacentTo(src, grabbing))
		return

	if(!CanUseLimb(grabbing_with))
		return

	if(GetEquipped(grabbing_slot))
		Notify("You are already holding something there!")
		return

	for(var/obj/item/grab/grab in active_grabs)
		if(grab.grabbed == grabbing)
			Notify("You already have a grip on \the [grabbing].")
			return

	if(grabbing.Burn(src, SLOT_HANDS))
		Notify("\The [src] is far too hot to grab!")
		return

	if(!grabbing.IsSolid())
		NotifyNearby("\The [src] attempts to grab \the [grabbing], but [grabbing.They()] slip[grabbing.s()] through [Their()] grasp.")
		return

	var/obj/item/grab/grab = new(src, grabbing)
	CollectItem(grab, grabbing_slot)
	var/obj/item/limb/limb = limbs[grabbing_with]
	PlayLocalSound(src, 'sounds/effects/whoosh1.ogg', 75)
	NotifyNearby("\The [grab.owner] grabs \the [grab.grabbed] with [grab.owner.Their()] [limb.grasp_name]!")
	grab.owner.DoAttackAnimation(grab.grabbed)


