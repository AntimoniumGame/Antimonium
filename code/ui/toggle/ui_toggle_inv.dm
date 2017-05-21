/obj/ui/toggle/inv
	name = "Show/Hide Inventory"
	icon_state = "toggle_inv_on"
	base_icon_state = "toggle_inv"
	toggle_state = TRUE
	screen_loc = "1,1"

/obj/ui/toggle/inv/ToggleState()
	..()
	for(var/slot in owner.inventory_slots)
		var/obj/ui/inv/inv_slot = owner.inventory_slots[slot]
		if(inv_slot.concealable)
			inv_slot.invisibility = toggle_state ? INVISIBILITY_MAXIMUM : 0
