/turf
	name = "floor"
	icon = 'icons/turfs/_floor.dmi'
	icon_state = "1"
	layer = TURF_LAYER
	luminosity = 1

/turf/stone
	name = "cobblestones"
	icon = 'icons/turfs/cobbles.dmi'
	icon_state = "1"

/turf/tiles
	name = "tiled floor"
	icon = 'icons/turfs/tiles.dmi'

/turf/stone/New()
	..()
	icon_state = "[rand(1,3)]"

/turf/proc/GetSimulatedAtoms()
	var/list/valid_targets = list()
	for(var/thing in contents)
		var/atom/target = thing
		if(istype(target) && (target.flags & FLAG_SIMULATED))
			valid_targets += target
	return valid_targets

/turf/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	if(clicker.intent.selecting == INTENT_HARM)
		var/list/valid_targets = GetSimulatedAtoms()
		if(!valid_targets.len) return
		var/atom/thing = pick(valid_targets)
		thing.LeftClickedOn(clicker, slot)

/turf/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	if(clicker.intent.selecting == INTENT_HARM)
		var/list/valid_targets = GetSimulatedAtoms()
		if(!valid_targets.len) return
		var/atom/thing = pick(valid_targets)
		thing.RightClickedOn(clicker, slot)

/turf/GetWeight()
	return 10

/turf/RadiateHeat(var/amount, var/distance = 1)
	. = ..()
	for(var/turf/neighbor in Trange(distance, src))
		var/falloff = max(1,(get_dist(src, neighbor)*2)-1)
		for(var/thing in neighbor.contents)
			var/atom/heating = thing
			heating.GainHeat(round(. / falloff), GetWeight())

/turf/proc/GetFootstepSound(var/mob/walker)
	return 'sounds/effects/footstep1.wav'

/turf/proc/GetSoundEnvironment()
	return -1
