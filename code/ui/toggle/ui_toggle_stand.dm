/obj/ui/toggle/prone
	base_icon_state = "sit"
	screen_loc = "4,2"

/obj/ui/toggle/prone/ToggleState()

	if(owner.prone)
		if(!owner.CanStand())
			owner.Notify("<span class='warning'>You are not currently able to stand up.</span>")
			return
		owner.ToggleProne(deliberate = TRUE)
	else if(owner.sitting)
		owner.ToggleSitting(deliberate = TRUE)
	else
		for(var/obj/structure/seat in owner.loc)
			if(istype(seat) && (seat.flags & FLAG_SEATING) && !owner.sitting && !owner.prone)
				owner.SetDir(seat.dir)
				owner.ToggleSitting(deliberate = TRUE)
		if(!owner.sitting)
			owner.ToggleProne(deliberate = TRUE)

	UpdateIcon()

/obj/ui/toggle/prone/UpdateIcon()
	toggle_state = (owner.prone || owner.sitting)
	. = ..()