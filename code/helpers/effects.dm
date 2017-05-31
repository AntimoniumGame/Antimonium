/proc/Splatter(var/turf/splatter_on, var/material_type)

	if(!material_type)
		return

	if(!istype(splatter_on))
		splatter_on = get_turf(splatter_on)
		if(!istype(splatter_on))
			return

	for(var/thing in splatter_on)
		var/atom/nearby = thing
		if(nearby.flags & FLAG_SIMULATED)
			nearby.SmearWith(GetUniqueDataByPath(material_type))

	if(!(locate(/obj/effect/random/splat) in splatter_on))
		PlayLocalSound(splatter_on, 'sounds/effects/drip1.ogg', 50)
	return new /obj/effect/random/splat(splatter_on, material_type, null, 5)

/proc/Smear(var/turf/from_turf, var/turf/to_turf, var/material_type, var/footprint)
	var/smear_dir = get_dir(from_turf, to_turf)
	var/list/splatters = list()
	splatters += new /obj/effect/random/splat/smear(from_turf, material_type, null, 0, smear_dir, footprint ? "walk_from" : "smear_from")
	splatters += new /obj/effect/random/splat/smear(to_turf, material_type, null, 0, smear_dir, footprint ? "walk_to" : "smear_to")
	return splatters

/proc/DoFadein(var/mob/fader, var/delay = 10)

	set waitfor = 0

	if(!fader.client)
		return

	var/obj/effect/blackout/blackout = new()
	blackout.alpha = 255
	blackout.mouse_opacity = 1
	fader.client.screen += blackout

	animate(blackout, alpha=0, time=delay)

	sleep(delay)

	if(blackout)
		blackout.mouse_opacity = 0
		if(fader && fader.client)
			fader.client.screen -= blackout
		QDel(blackout)

/proc/DoFadeout(var/mob/fader, var/delay = 10)

	set waitfor = 0

	if(!fader.client)
		return

	var/obj/effect/blackout/blackout = new()
	blackout.alpha = 0
	blackout.mouse_opacity = 1
	fader.client.screen += blackout

	animate(blackout, alpha=255, time=delay)

	sleep(delay)

	if(blackout)
		blackout.mouse_opacity = 0
		if(fader && fader.client)
			fader.client.screen -= blackout
		QDel(blackout)
