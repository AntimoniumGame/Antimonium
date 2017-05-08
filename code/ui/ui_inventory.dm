/obj/ui/inv
	name = "Inventory"
	var/obj/item/holding
	var/slot_id

/obj/ui/inv/destroy()
	holding = null
	. = ..()

/obj/ui/inv/middle_clicked_on(var/mob/clicker)
	. = ..()
	if(. && holding)
		owner.drop_item(holding)

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
	name = initial(name)
	overlays.Cut()
	if(holding)
		name = "[name] - [holding.name]"
		overlays += holding.get_inv_icon()

/obj/ui/inv/hand
	name = "left hand"
	screen_loc = "7,2"
	slot_id = "left_hand"

/obj/ui/inv/hand/right
	name = "right hand"
	screen_loc = "8,2"
	slot_id = "right_hand"

/obj/ui/inv/hand/left_clicked_on(var/mob/clicker)
	. = ..()
	if(. && slot_id == "left_hand" && holding)
		holding.use(clicker)

/obj/ui/inv/hand/right_clicked_on(var/mob/clicker)
	. = ..()
	if(. && slot_id == "right_hand" && holding)
		holding.use(clicker)
