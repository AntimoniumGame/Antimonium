/obj/item/grab
	icon = 'icons/objects/items/grab.dmi'
	var/mob/human/owner
	var/atom/movable/grabbed
	flags = 0

/obj/item/grab/New(var/newloc, var/atom/movable/_grabbed, var/mob/human/_owner)
	..(newloc)
	owner = _owner
	owner.active_grabs += src
	grabbed = _grabbed
	name = "grip on \the [grabbed]"
	processing_objects += src

/obj/item/grab/AfterDropped()
	QDel(src, "grab dropped")

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
		QDel(src, "grab state fail")
		return FALSE
	return TRUE

/mob
	var/list/active_grabs = list()

/mob/proc/GrabAtom(var/atom/movable/grabbing, var/grabbing_with, var/grabbing_slot)

	if(!IsAdjacentTo(src, grabbing) || OnActionCooldown())
		return

	if(!CanUseLimb(grabbing_with))
		return

	if(GetEquipped(grabbing_slot))
		Notify("<span class='warning'>You are already holding something there!</span>")
		return

	for(var/obj/item/grab/grab in active_grabs)
		if(grab.grabbed == grabbing)
			Notify("<span class='warning'>You already have a grip on \the [grabbing].</span>")
			return

	if(grabbing.Burn(src, SLOT_HANDS))
		Notify("<span class='warning'>\The [grabbing] is far too hot to grab!</span>")
		return

	if(!grabbing.IsSolid())
		NotifyNearby("<span class='warning'>\The [src] attempts to grab \the [grabbing], but [grabbing.They()] slip[grabbing.s()] through [Their()] grasp.</span>")
		return

	var/obj/item/grab/grab = new(null, grabbing, src)
	grab.ForceMove(get_turf(src))
	if(CollectItem(grab, grabbing_slot))
		var/obj/item/limb/limb = GetLimb(grabbing_with)
		PlayLocalSound(src, 'sounds/effects/whoosh1.ogg', 75)
		NotifyNearby("<span class='danger'>\The [grab.owner] grabs \the [grab.grabbed] with [grab.owner.Their()] [limb.grasp_name]!</span>")
		SetActionCooldown(10)
		grab.owner.DoAttackAnimation(grab.grabbed)
