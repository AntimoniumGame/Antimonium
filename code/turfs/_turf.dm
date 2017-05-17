/turf
	name = "floor"
	icon = 'icons/turfs/turf.dmi'
	layer = TURF_LAYER
	luminosity = 1

/turf/wall
	name = "wall"
	density = 1
	opacity = 1
	icon_state = "wall"

/turf/proc/get_simulated_atoms()
	var/list/valid_targets = list()
	for(var/thing in contents)
		var/atom/target = thing
		if(istype(target) && (target.flags & FLAG_SIMULATED))
			valid_targets += target
	return valid_targets

/turf/left_clicked_on(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	if(clicker.intent.selecting == INTENT_HARM)
		var/list/valid_targets = get_simulated_atoms()
		if(!valid_targets.len) return
		var/atom/thing = pick(valid_targets)
		thing.left_clicked_on(clicker, slot)

/turf/right_clicked_on(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	if(clicker.intent.selecting == INTENT_HARM)
		var/list/valid_targets = get_simulated_atoms()
		if(!valid_targets.len) return
		var/atom/thing = pick(valid_targets)
		thing.right_clicked_on(clicker, slot)

/turf/get_weight()
	return 10

/turf/radiate_heat(var/amount, var/distance = 1)
	. = ..()
	for(var/turf/neighbor in trange(distance, src))
		var/falloff = max(1,(get_dist(src, neighbor)*2)-1)
		for(var/thing in neighbor.contents)
			var/atom/heating = thing
			heating.gain_heat(round(. / falloff), get_weight())

/turf/proc/get_footstep_sound(var/mob/walker)
	return 'sounds/effects/footstep1.wav'

/turf/proc/get_sound_environment()
	return -1
