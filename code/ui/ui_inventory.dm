/obj/ui/inv
	name = "Inventory"
	var/obj/item/holding
	var/slot_id
	var/unmodified_name

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
	name = unmodified_name
	overlays.Cut()
	if(holding)
		name = "[name] - [holding.name]"
		overlays += holding.get_inv_icon()

/obj/ui/inv/hand
	name = "left hand"
	screen_loc = "7,2"
	slot_id = "left_hand"

/obj/ui/inv/hand/New(var/mob/_owner, var/nname, var/nscreen_loc, var/nslot_id)
	. = ..()
	if(nname)
		name = nname
	unmodified_name = name
	if(nscreen_loc)
		screen_loc = nscreen_loc
	if(nslot_id)
		slot_id = nslot_id

/obj/ui/inv/hand/left_clicked_on(var/mob/clicker)
	. = ..()
	if(. && slot_id == "left_hand" && holding)
		holding.use(clicker)

/obj/ui/inv/hand/right_clicked_on(var/mob/clicker)
	. = ..()
	if(. && slot_id == "right_hand" && holding)
		holding.use(clicker)
