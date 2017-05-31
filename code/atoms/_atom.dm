/atom
	name = ""
	plane = MASTER_PLANE
	layer = UNDERLAY_LAYER
	var/flags = FLAG_SIMULATED | FLAG_THROWN_SPIN

/atom/movable
	animate_movement = SLIDE_STEPS
	var/dragged = FALSE
	var/self_move = FALSE
	var/move_sound

	var/shadow_size = null
	var/shadow_pixel_x = 0
	var/shadow_pixel_y = 0

/atom/proc/UpdateIcon(var/list/supplied = list())
	overlays = supplied
	var/mob/holder = loc
	if(istype(holder))
		holder.UpdateInventory()
		holder.UpdateIcon()

/atom/movable/UpdateIcon(var/list/supplied = list())
	if((flags & FLAG_SIMULATED) && !isnull(shadow_size))
		underlays.Cut()
		var/image/I = image(icon = 'icons/images/atom_shadows.dmi', icon_state = "[shadow_size]")
		I.alpha = 30
		I.plane = FLOAT_PLANE // stays with the parent plane regardless of if it changes
		I.layer = FLOAT_LAYER
		I.pixel_x = shadow_pixel_x
		I.pixel_y = shadow_pixel_y
		underlays += I
	..(supplied)

/atom/proc/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	return

/atom/proc/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	return

/atom/proc/MiddleClickedOn(var/mob/clicker)
	ExaminedBy(clicker)

/atom/proc/ExaminedBy(var/mob/clicker)
	clicker.Notify("[(src != clicker) ? "That's" : "You're"] \a [name].")
	return IsAdjacentTo(src, clicker)

/atom/proc/PullCost()
	return 1

/atom/New()
	..()
	if(!game_state || game_state.ident == GAME_SETTING_UP)
		atoms_to_initialize += src
	else
		Initialize()

/atom/proc/Initialize()
	SetDir(dir)
	UpdateStrings()
	UpdateIcon()

/atom/movable/proc/HandleDragged(var/turf/from_turf, var/turf/to_turf)
	if(move_sound)
		PlayLocalSound(src, move_sound, 35, frequency = -1)

/atom/proc/UpdateStrings()
	name = initial(name)

/atom/proc/Airtight()
	return FALSE

/atom/proc/IsSolid()
	return TRUE

/atom/proc/GetWeight()
	return 1

/atom/proc/GetAmount()
	return 1

/atom/proc/SmearWith(var/datum/material/smearing, var/amount)
	return
