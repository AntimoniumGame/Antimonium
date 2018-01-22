/obj/item/limb/grasp/HandleSeverEffects()
	if(owner.GetEquipped(limb_id))
		owner.DropItem(owner.GetEquipped(limb_id))

/obj/item/limb/grasp/HandleBreakEffects()
	var/obj/item/held = owner.GetEquipped(limb_id)
	if(held)
		owner.NotifyNearby("\The [owner]'s broken [name] cannot hold [owner.Their()] [held.name], and [held.They()] drop to the ground.", MESSAGE_VISIBLE)
		owner.DropItem(held)

/obj/item/limb/grasp/IsDextrous(var/silent)
	return TRUE
