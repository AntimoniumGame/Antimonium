/proc/blood_splatter(var/mob/bleeder, var/turf/bleeding_on)
	if(!istype(bleeding_on, /turf))
		bleeding_on = get_turf(bleeding_on)
	if(istype(bleeding_on))
		if(!(locate(/obj/effect/random/blood) in bleeding_on))
			play_local_sound(bleeding_on, 'sounds/effects/drip1.wav', 50)
		new /obj/effect/random/blood(bleeding_on, bleeder)

/proc/blood_smear(var/mob/bleeder, var/turf/from_turf, var/turf/to_turf)
	var/smear_dir = get_dir(from_turf, to_turf)
	new /obj/effect/blood_smear(from_turf, smear_dir, "smear_from")
	new /obj/effect/blood_smear(to_turf, smear_dir, "smear_to")


/proc/do_fadein(var/mob/fader, var/delay = 10)

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
		qdel(blackout)

/proc/do_fadeout(var/mob/fader, var/delay = 10)

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
		qdel(blackout)
