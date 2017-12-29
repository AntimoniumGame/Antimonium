/turf
	layer = TURF_LAYER
	luminosity = 1
	flags = FLAG_TEMPERATURE_SENSITIVE | FLAG_SIMULATED
	icon_state = "1"

	var/datum/material/wall_material
	var/datum/material/floor_material

	var/debris_counter = 0
	var/list/wall_overlays		// overlays that makeup a wall turf
	var/list/floor_overlays		// overlays that makeup a floor turf
	var/list/ao_overlays		// ambient occlusion overlays (cast on a floor when next to a wall)

/turf/GetRadialMenuContents(var/mob/user, var/menu_type, var/args)
	if(menu_type == RADIAL_MENU_DEFAULT)
		var/list/simulated_atoms = list()
		for(var/thing in contents)
			var/atom/atom = thing
			if(istype(atom) && (atom.flags & FLAG_SIMULATED) && atom.invisibility <= user.see_invisible && !Deleted(atom))
				simulated_atoms += atom
		return simulated_atoms
	return list()

/turf/MiddleClickedOn(var/mob/clicker)
	if(IsAdjacentTo(src, clicker))
		new /obj/ui/radial_menu(clicker, src)
		return TRUE
	. = ..()

/turf/UpdateStrings()
	if(wall_material)
		name = "[wall_material.GetDescriptor()] wall"
	else if(floor_material)
		name = "[floor_material.GetDescriptor()] floor"
	else
		name = "floor"

/turf/New(var/newloc, var/_floor_material, var/_wall_material)
	if(_floor_material) floor_material = GetUniqueDataByPath(_floor_material)
	if(_wall_material) wall_material = GetUniqueDataByPath(_wall_material)
	if(!floor_material)
		if(wall_material)
			floor_material = wall_material
		else
			floor_material = GetUniqueDataByPath(/datum/material/dirt)

	if(floor_material)
		icon = floor_material.turf_floor_icon
		if(floor_material.turf_base_states > 1)
			icon_state = "[rand(1,floor_material.turf_base_states)]"
		else
			icon_state = "1"

	if(wall_material)
		max_damage = wall_material.structural_integrity
		density = wall_material.turf_wall_is_dense
		opacity = !wall_material.turf_wall_is_transparent
	else
		density = 0
		opacity = 0

	..(newloc)

/turf/Initialize()
	SetDir(dir)
	UpdateStrings()
	UpdateIcon(ignore_neighbors = (!game_state || game_state.ident != GAME_RUNNING))

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

		if(floor_material && floor_material.OnTurfAttack(src, user, prop))
			return TRUE

		if(wall_material && wall_material.OnTurfAttack(src, user, prop))
			return TRUE

		if(wall_material && (prop.associated_skill & (wall_material.demolition_skill|SKILL_DEMOLITION)))
			user.DoAttackAnimation(get_turf(src))
			NotifyNearby("<span class='danger'>\The [user] strikes \the [src] with \the [prop]!</span>", MESSAGE_VISIBLE)
			PlayLocalSound(src, wall_material.hit_sound, 100)
			user.SetActionCooldown(6)
			TakeDamage(10, user)
			return TRUE
		else if(floor_material && floor_material.turf_is_diggable && (prop.associated_skill & (floor_material.demolition_skill)))
			DigEarthworks(user)
			return TRUE

		var/list/valid_targets = GetSimulatedAtoms()
		if(!valid_targets.len) return
		var/atom/thing = pick(valid_targets)
		if(thing.AttackedBy(user, prop))
			user.SetActionCooldown(3)
			return TRUE

/turf/proc/DestroyWall()
	if(wall_material || density)
		damage = 0
		max_damage = max(1,round(max_damage * 0.5))
		debris_counter = 0
		wall_material = null
		density = 0
		opacity = 0
		UpdateIcon()
		UpdateStrings()

/turf/ManipulatedBy(var/mob/user, var/obj/item/prop, var/slot)
	. = ..()
	if(!. && !user.OnActionCooldown())
		if(floor_material && floor_material.turf_is_diggable && user.IsDigger())
			DigEarthworks(user, slot, check_digger = TRUE)
			return TRUE

/turf/GetWeight()
	return 10

/turf/proc/GetFootstepSound(var/mob/walker)
	return 'sounds/effects/footstep1.ogg'

/turf/proc/GetSoundEnvironment()
	return -1

/turf/IsFlammable()
	return ((wall_material && wall_material.IsFlammable()) || (floor_material && floor_material.IsFlammable()))

/turf/proc/DigEarthworks(var/mob/user, var/slot, var/check_digger = FALSE)

	if(slot && !user.CanUseInvSlot(slot))
		return FALSE

	if(locate(/obj/structure/earthworks) in src)
		user.Notify("There are already earthworks here. You will need to fill them in before digging.")
		return TRUE

	if(user.intent.selecting == INTENT_HELP && (!check_digger || user.IsDigger(TRUE)))
		user.NotifyNearby("\The [user] carefully tills the soil into a farm.", MESSAGE_VISIBLE)
		new /obj/structure/earthworks/farm(src)
	else
		user.NotifyNearby("\The [user] digs a long, deep pit.", MESSAGE_VISIBLE)
		new /obj/structure/earthworks/pit(src)

/turf/UpdateIcon(var/ignore_neighbors)

	if(!floor_material && !wall_material)
		return

	overlays -= wall_overlays | floor_overlays | ao_overlays

	wall_overlays = list()
	floor_overlays = list()
	ao_overlays = list()

	var/list/connected_neighbors = list()
	var/list/shadow_edges = list()
	var/list/blend_dirs = list()

	for(var/thing in Trange(1,src))

		if(thing == src)
			continue
		var/turf/neighbor = thing
		var/use_dir = get_dir(src, neighbor)

		if(neighbor.floor_material)
			if(!isnull(neighbor.floor_material.turf_edge_layer) && (isnull(floor_material.turf_edge_layer) || floor_material.turf_edge_layer < neighbor.floor_material.turf_edge_layer))
				blend_dirs["[use_dir]"] = list(neighbor.floor_material.turf_floor_icon, neighbor.floor_material.turf_edge_layer)

		if(neighbor.density)
			connected_neighbors += get_dir(src, neighbor)
		else
			shadow_edges += use_dir

		if(!ignore_neighbors)
			neighbor.UpdateIcon(ignore_neighbors = TRUE)

	if(floor_material)

		if(blend_dirs.len)
			for(var/blend_dir in blend_dirs)
				var/list/blend_data = blend_dirs[blend_dir]
				var/image/I = image(blend_data[1], "edges", dir = text2num(blend_dir))
				I.layer = layer + blend_data[2]
				floor_overlays += I

		if(floor_material.turf_effect_overlay)
			floor_overlays += image(icon, floor_material.turf_effect_overlay)

	if(wall_material)
		for(var/i = 1 to 4)
			var/cdir = corner_dirs[i]
			var/corner = 0
			if(cdir in connected_neighbors)
				corner |= 2
			if(turn(cdir,45) in connected_neighbors)
				corner |= 1
			if(turn(cdir,-45) in connected_neighbors)
				corner |= 4
			var/image/I = image(wall_material.turf_wall_icon, "[corner]", dir = 1<<(i-1))
			I.layer = MOB_LAYER
			wall_overlays += I
	else
		for(var/i = 1 to 4)
			var/cdir = corner_dirs[i]
			var/corner = 0
			if(cdir in shadow_edges)
				corner |= 2
			if(turn(cdir,45) in shadow_edges)
				corner |= 1
			if(turn(cdir,-45) in shadow_edges)
				corner |= 4
			var/image/I = image('icons/images/turf_shadows.dmi', "[corner]", dir = 1<<(i-1))
			I.layer = TURF_LAYER + 0.95
			I.alpha = 80
			ao_overlays += I

	overlays += wall_overlays | floor_overlays | ao_overlays
	UpdateFireOverlay()

/turf/Entered(var/atom/movable/crosser, var/oldloc)
	. = ..(crosser, oldloc)
	if(floor_material) floor_material.OnTurfEntry(src, crosser)
	if(wall_material)  wall_material.OnTurfEntry(src, crosser)

/turf/TakeDamage(var/dam, var/source)

	damage += dam
	debris_counter += dam
	while(debris_counter >= 10)
		debris_counter -= 10
		var/atom/movable/debris
		if(wall_material)
			debris = wall_material.GetDebris(1)
		else if(floor_material)
			debris = floor_material.GetDebris(1)
		if(debris)
			debris.ForceMove(source ? get_turf(source) : src)

	if(damage > max_damage)
		if(wall_material)
			DestroyWall()
		else if(floor_material && floor_material.type != /datum/material/dirt)
			new /turf/floor/dirt(src)

	..()

/turf/Enter(var/atom/movable/mover, var/oldloc)
	// Ghosts get a free pass.
	if(!(mover.flags & FLAG_SIMULATED))
		return TRUE
	// Dense walls cannot be bypassed.
	if(density)
		return FALSE
	// Handle mobs moving from structure to structure (walking across tables for example)
	var/turf/T = oldloc
	if(istype(mover, /mob) && mover.density && !density && istype(T))
		var/blocked = FALSE
		for(var/thing in contents)
			if(istype(thing, /mob))
				var/mob/M = thing
				if(M.density && (M.flags & FLAG_SIMULATED))
					return 0
			if(istype(thing, /obj/structure))
				var/obj/structure/structure = thing
				if(structure.density)
					blocked = TRUE
					break
		if(blocked)
			for(var/obj/structure/structure in T)
				if(structure.density)
					blocked = FALSE
					break
		return !blocked
	. = ..()
