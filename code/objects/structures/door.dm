/obj/structure/door
	name = "door"
	default_material_path = /datum/material/wood
	flags = FLAG_SIMULATED | FLAG_ANCHORED
	icon = 'icons/objects/structures/door.dmi'
	icon_state = "door"
	opacity = 1
	density = 1
	pixel_y = -16
	draw_shadow_underlay = null
	var/locked = FALSE

/obj/structure/door/SetDir(var/newdir)
	..(newdir)
	switch(dir)
		if(NORTH)
			pixel_x = -32
			pixel_y = -16
		if(SOUTH)
			pixel_x = 0
			pixel_y = -16
		if(EAST)
			pixel_x = -16
			pixel_y = 0
		if(WEST)
			pixel_x = -16
			pixel_y = -32

/obj/structure/door/PushedBy(var/mob/user)
	ToggleOpen(user)
	user.SetActionCooldown(2)
	return TRUE

// Inherits from containers, but overrides.
/obj/structure/door/ToggleOpen(var/mob/user, var/slot)

	var/opener_dir = get_dir(src, user)
	var/slam = ((user.intent.selecting != INTENT_HELP) || !user.walking)

	for(var/thing in get_turf(src))
		if(thing == src) continue
		var/atom/atom = thing
		if(atom.density && (atom.flags & FLAG_SIMULATED))
			NotifyNearby("<span class='warning'>\The [src] [slam ? "bashes into" : "clunks on"] \the [atom] and fails to [density ? "open" : "close"].</span>", MESSAGE_VISIBLE)
			PlayLocalSound(loc, 'sounds/effects/thump1.ogg', 100)
			return TRUE
	var/anim_time = (slam ? 2 : 5)
	if(open)
		open = FALSE
		density = 1
		opacity = 1
		animate(src, time = anim_time, transform = null)
		PlayLocalSound(loc, (slam ? 'sounds/effects/door_slam_close.ogg' : 'sounds/effects/door_close.ogg'), 100)
		return TRUE

	if(locked)
		return FALSE

	open = TRUE
	density = 0
	opacity = 0
	PlayLocalSound(loc, 'sounds/effects/door_open.ogg', 100)
	if(opener_dir & dir)
		animate(src, time = anim_time, transform = turn(matrix(), 90))
	else
		animate(src, time = anim_time, transform = turn(matrix(), -90))
	return TRUE

/obj/structure/door/north
	dir = NORTH
	pixel_x = -32
	pixel_y = -16

/obj/structure/door/south
	dir = SOUTH
	pixel_x = 0
	pixel_y = -16

/obj/structure/door/east
	dir = EAST
	pixel_x = -16
	pixel_y = 0

/obj/structure/door/west
	dir = WEST
	pixel_x = -16
	pixel_y = -32
