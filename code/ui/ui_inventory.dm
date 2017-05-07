/obj/ui/inv
	name = "Inventory"
	var/obj/item/holding
	var/slot_id

/obj/ui/inv/destroy()
	holding = null
	. = ..()

/obj/ui/inv/clicked_on(var/mob/clicker)
	. = ..()
	if(.)
		if(holding)
			owner.notify("You are holding \a [holding] in your [name].")
		else
			owner.notify("Your [name] is empty.")

/obj/ui/inv/proc/set_held(var/obj/item/thing)
	if(holding)
		owner.drop_item(holding)
		holding = null
	holding = thing
	update_icon()

/obj/ui/inv/proc/forget_held()
	holding = null
	update_icon()

/obj/ui/inv/proc/update_icon()
	overlays.Cut()
	if(holding)
		world << "adding overlay to [src] for [holding]"
		overlays += holding.get_held_icon()

/obj/ui/inv/left_hand
	name = "left hand"
	screen_loc = "7,2"
	slot_id = "left_hand"

/obj/ui/inv/right_hand
	name = "right hand"
	screen_loc = "8,2"
	slot_id = "right_hand"
