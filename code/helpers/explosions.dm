var/mob/abstract/viewer/fake_viewer

/proc/GetFakeView(var/radius, var/turf/center)
	center = get_turf(center)
	if(!istype(center)) return list()
	if(!fake_viewer) fake_viewer = new()
	fake_viewer.loc = center
	var/list/in_view = view(radius, fake_viewer)
	fake_viewer.NullLoc()
	return in_view

/mob/abstract/viewer
	invisibility = INVISIBILITY_MAXIMUM+1 //ultra mega super invisible
	alpha = 0
	flags = 0

/proc/InitializeFakeViewer()

/proc/DoExplosion(var/turf/epicenter, var/radius = 3, var/severity = 5)
	PlayLocalSound(epicenter, 'sounds/effects/bang1.ogg', 100)
	var/list/visible = GetFakeView(radius, epicenter)
	for(var/thing in Crange(radius, epicenter))
		if(thing in visible)
			var/turf/turf = thing
			turf.TakeExplosionDamage(severity)
	radius = round(radius * 1.75)
	visible = GetFakeView(radius, epicenter)
	for(var/thing in Crange(radius, epicenter))
		if(thing in visible)
			var/turf/turf = thing
			if(prob(min(100, severity*2)))
				turf.Ignite()

/atom/proc/TakeExplosionDamage(var/severity)
	return

/turf/TakeExplosionDamage(var/severity)
	if(flags & FLAG_SIMULATED)
		for(var/atom/thing in contents)
			if(thing.flags & FLAG_SIMULATED)
				thing.TakeExplosionDamage(severity)
		TakeDamage(max(1,rand(severity-3, severity+3)))