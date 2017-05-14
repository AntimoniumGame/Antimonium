/obj/item/limb/grasp/handle_sever_effects()
	if(owner.get_equipped(limb_id))
		owner.drop_item(owner.get_equipped(limb_id))

/obj/item/limb/grasp/handle_break_effects()
	var/obj/item/held = owner.get_equipped(limb_id)
	if(held)
		owner.notify_nearby("\The [owner]'s broken [name] cannot hold [owner.their()] [held.name], and [held.they()] drop to the ground.")
		owner.drop_item(held)

/obj/item/limb/grasp/is_dextrous()
	return TRUE
