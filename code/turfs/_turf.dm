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
		if(istype(target) && (target.interaction_flags & FLAG_SIMULATED))
			valid_targets += target
	return valid_targets

/turf/left_clicked_on(var/mob/clicker)
	if(clicker.intent.selecting == INTENT_HARM)
		var/list/valid_targets = get_simulated_atoms()
		if(!valid_targets.len) return
		var/atom/thing = pick(valid_targets)
		thing.left_clicked_on(clicker)

/turf/right_clicked_on(var/mob/clicker)
	if(clicker.intent.selecting == INTENT_HARM)
		var/list/valid_targets = get_simulated_atoms()
		if(!valid_targets.len) return
		var/atom/thing = pick(valid_targets)
		thing.right_clicked_on(clicker)
