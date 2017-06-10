/turf
	layer = TURF_LAYER
	luminosity = 1
	flags = FLAG_TEMPERATURE_SENSITIVE | FLAG_SIMULATED
	var/edge_blend_layer

/turf/Initialize()
	SetDir(dir)
	UpdateStrings()
	UpdateIcon(ignore_neighbors = (!game_state || game_state.ident != GAME_RUNNING))
//	SetOpacity(opacity)

/turf/proc/GetSimulatedAtoms()
	var/list/valid_targets = list()
	for(var/thing in contents)
		var/atom/target = thing
		if(istype(target) && (target.flags & FLAG_SIMULATED))
			valid_targets += target
	return valid_targets

/turf/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	HandleInteraction(clicker, slot)

/turf/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	HandleInteraction(clicker, slot)

/turf/proc/HandleInteraction(var/mob/clicker, var/slot = SLOT_LEFT_HAND)

	if(clicker.OnActionCooldown())
		return

	if(IsAdjacentTo(clicker, src))
		if(clicker.GetEquipped(slot))
			if(AttackedBy(clicker, clicker.GetEquipped(slot)))
				clicker.SetActionCooldown(3)
		else
			if(ManipulatedBy(clicker, slot))
				clicker.SetActionCooldown(3)

/turf/AttackedBy(var/mob/user, var/obj/item/prop)
	. = ..()
	if(!. && !user.OnActionCooldown())
		var/list/valid_targets = GetSimulatedAtoms()
		if(!valid_targets.len) return
		var/atom/thing = pick(valid_targets)
		if(thing.AttackedBy(user, prop))
			user.SetActionCooldown(3)
			return TRUE

/turf/GetWeight()
	return 10

/turf/proc/GetFootstepSound(var/mob/walker)
	return 'sounds/effects/footstep1.ogg'

/turf/proc/GetSoundEnvironment()
	return -1
