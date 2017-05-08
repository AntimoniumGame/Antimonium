/obj/ui/hide_inv
	name = "Show/Hide Inventory"
	icon_state = "toggle_inv_on"
	screen_loc = "1,1"
	var/hiding_inventory = TRUE

/obj/ui/hide_inv/left_clicked_on(var/mob/clicker)
	. = ..()
	if(.)
		toggle_hide_inv()

/obj/ui/hide_inv/right_clicked_on(var/mob/clicker)
	. = ..()
	if(.)
		toggle_hide_inv()

/obj/ui/hide_inv/middle_clicked_on(var/mob/clicker)
	. = ..()
	if(.)
		toggle_hide_inv()

/obj/ui/hide_inv/proc/toggle_hide_inv()

	hiding_inventory = !hiding_inventory
	icon_state = "toggle_inv_[hiding_inventory ? "on" : "off"]"
	for(var/slot in owner.inventory_slots)
		var/obj/ui/inv/inv_slot = owner.inventory_slots[slot]
		if(inv_slot.concealable)
			inv_slot.invisibility = hiding_inventory ? INVISIBILITY_MAXIMUM : 0
