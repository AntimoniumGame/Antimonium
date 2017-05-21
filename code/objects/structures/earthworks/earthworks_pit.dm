/obj/structure/earthworks/pit
	name = "pit"
	icon = 'icons/objects/structures/pit.dmi'
	icon_state = "open"

/obj/structure/earthworks/pit/MovementInContents(var/mob/mover)
	. = ..()
	if(mover.CanMove())
		if(icon_state == "open")
			mover.ForceMove(get_turf(src))
		else
			if(prob(5))
				DigUp()
				mover.NotifyNearby("\The [mover] claws [mover.Their()] way out of \the [src].")
			else
				mover.Notify("You claw desperately at the packed earth surrounding you, but make little progress.")
				NotifyNearby("A muffled scratching sound rises up from \the [src].")
				. += 15

/obj/structure/earthworks/pit/proc/DigUp(var/mob/user)
	icon_state = "open"
	var/list/removed = list()
	for(var/thing in contents)
		var/atom/movable/atom = thing
		if(istype(atom) && (atom.flags & FLAG_SIMULATED))
			atom.ForceMove(get_turf(src))
			removed += atom
	if(user && removed.len)
		user.NotifyNearby("\The [user] digs up \the [src], revealing [removed.len] object\s.")

/obj/structure/earthworks/pit/AttackedBy(var/mob/user, var/obj/item/prop)
	if(icon_state != "open")
		DigUp(user)
		return
	. = ..()

/obj/structure/earthworks/pit/FillIn(var/mob/user)
	if(istype(loc, /turf))
		var/turf/turf = loc
		var/list/burying = list()
		for(var/thing in turf.contents)
			var/atom/atom = thing
			if((atom.flags & FLAG_SIMULATED) && !(atom.flags & (FLAG_ANCHORED|FLAG_ETHEREAL)))
				burying += atom
		if(burying.len)
			for(var/thing in burying)
				var/atom/movable/atom = thing
				if(istype(atom))
					atom.ForceMove(src)
			icon_state = "closed"
			user.NotifyNearby("\The [user] fills in \the [src], burying [burying.len] object\s inside it.")
			return
	. = ..()
