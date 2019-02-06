/obj/item/grab
	icon = 'icons/objects/items/grab.dmi'
	var/mob/owner
	var/atom/movable/grabbed
	var/complex
	flags = 0

/obj/item/grab/New(var/newloc, var/atom/movable/_grabbed, var/mob/human/_owner)
	..(newloc)
	owner = _owner
	owner.active_grabs += src
	grabbed = _grabbed
	name = "grip on \the [grabbed]"
	_glob.processing_objects += src

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
	_glob.processing_objects -= src
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

	var/grab_string
	var/mob/M = grabbing
	var/complex_grab
	if(istype(M))

		var/obj/item/limb/limb = M.limbs_by_key[target_zone.selecting]
		if(!istype(limb))
			Notify("<span class='warning'>\The [grabbing] is missing that limb.</span>")
			return

		if(intent.selecting == INTENT_HELP)
			if(target_zone.selecting == BP_CHEST || target_zone.selecting == BP_HEAD || target_zone.selecting == BP_GROIN)
				Notify("<span class='warning'>You will need to be aggressive if you want to grab them by that bodypart.</span>")
				return

		if(target_zone.selecting == BP_CHEST)
			grab_string = " in a shoulderlock"
			complex_grab = TRUE
		else if(target_zone.selecting == BP_HEAD)
			grab_string = " in a headlock"
			complex_grab = TRUE
		else if(target_zone.selecting == BP_GROIN)
			grab_string = " in a groinlock"
			complex_grab = TRUE
		else
			grab_string = " by \the [limb]"

	if(!grabbing.IsSolid())
		NotifyNearby("<span class='warning'>\The [src] attempts to [intent.selecting == INTENT_HELP ? "take" : "grab"] \the [grabbing][grab_string], but [grabbing.They()] slip[grabbing.s()] through [Their()] grasp.</span>", MESSAGE_VISIBLE)
		return

	if((intent.selecting == INTENT_HELP || complex_grab) && !DoAfter(10, grabbing, list("loc"), list("loc")))
		return

	var/obj/item/grab/grab = new(null, grabbing, src)
	grab.complex = complex_grab
	grab.ForceMove(get_turf(src))
	if(CollectItem(grab, grabbing_slot))
		var/obj/item/limb/limb = GetLimb(grabbing_with)
		if(grab.owner.intent.selecting == INTENT_HELP)
			PlayLocalSound(src, 'sounds/effects/rustle1.ogg', 75)
			NotifyNearby("<span class='notice'>\The [grab.owner] takes \the [grab.grabbed][grab_string] with [grab.owner.Their()] [limb.grasp_name].</span>", MESSAGE_VISIBLE)
		else
			PlayLocalSound(src, 'sounds/effects/whoosh1.ogg', 75)
			NotifyNearby("<span class='danger'>\The [grab.owner] grabs \the [grab.grabbed][grab_string] with [grab.owner.Their()] [limb.grasp_name]!</span>", MESSAGE_VISIBLE)
		SetActionCooldown(10)
		grab.owner.DoAttackAnimation(grab.grabbed)
