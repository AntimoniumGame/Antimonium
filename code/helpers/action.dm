/mob/var/performing_action = FALSE
/proc/DoAfterDelay(var/atom/movable/user, var/atom/target, var/delay, var/obj/item/held)

	var/user_loc = user.loc
	var/user_dir = user.dir
	var/target_loc = target.loc
	var/target_dir = target.dir
	var/mob/user_as_mob = user

	var/obj/ui/inv/held_slot

	if(held)
		if(!istype(user_as_mob))
			return FALSE
		if(user_as_mob.performing_action)
			return FALSE
		user_as_mob.performing_action = TRUE
		held_slot = user_as_mob.inventory_slots[user_as_mob.GetSlotByHandedness("left")]
		if(istype(held_slot) && held_slot.holding != held)
			held_slot = user_as_mob.inventory_slots[user_as_mob.GetSlotByHandedness("right")]
		if(istype(held_slot) && held_slot.holding != held)
			return FALSE
	. = TRUE
	var/i = delay
	while(i > 0)
		if(!user || Deleted(user) || !target || Deleted(target) || user.loc != user_loc || user_dir != user.dir || target_dir != target.dir || target.loc != target_loc)
			. = FALSE
			break
		if(held_slot && held)
			if(held_slot.holding != held || Deleted(held))
				. = FALSE
				break
		i--
		sleep(1)
	user_as_mob.performing_action = FALSE
	. = TRUE