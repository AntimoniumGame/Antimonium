/*
Mob interactions:
	attack_self() - the mob is attacking itself with a bare hand.
	attack(var/mob/target) - the mob is attacking a target with a bare hand.
*/

/mob
	icon = 'icons/mobs/_default.dmi'
	layer = MOB_LAYER
	see_invisible = SEE_INVISIBLE_LIVING
	var/dead = FALSE

/mob/New()
	..()
	gender = pick(MALE, FEMALE, NEUTER, PLURAL)
	mob_list += src
	if(dead)
		dead_mob_list += src
	else
		living_mob_list += src

/mob/destroy()
	dead_mob_list -= src
	living_mob_list -= src
	mob_list -= src
	. = ..()

/mob/proc/handle_life_tick()
	return

/mob/proc/die(var/cause)
	if(!dead)
		dead = TRUE
		living_mob_list -= src
		dead_mob_list |= src
		notify_nearby("<b>\The [src] has been slain by [cause]!</b>")
		return TRUE
	return FALSE

/mob/proc/update_stance()
	return

/mob/proc/do_fadein(var/delay = 10)

	set waitfor = 0
	set background = 1

	var/obj/blackout = new()
	blackout.name = "Antimonium"
	blackout.layer = SCREEN_EFFECTS_LAYER+0.5
	blackout.plane = SCREEN_PLANE
	blackout.screen_loc = "CENTER"
	blackout.icon = 'icons/images/barrier.dmi'
	blackout.icon_state = ""
	blackout.color = BLACK
	var/matrix/M = matrix()
	M.Scale(SCREEN_BARRIER_SIZE)
	blackout.transform = M

	// Add it to client.
	blackout.alpha = 255
	blackout.mouse_opacity = 1
	client.screen += blackout

	// Fade it out.
	if(blackout)
		animate(blackout, alpha=0, time=delay)
	sleep(delay)
	if(blackout)
		blackout.mouse_opacity = 0
		if(client)
			client.screen -= blackout
		qdel(blackout)

/mob/proc/do_fadeout(var/delay = 10)

	set waitfor = 0
	set background = 1

	var/obj/blackout = new()
	blackout.name = "Antimonium"
	blackout.layer = SCREEN_EFFECTS_LAYER+0.5
	blackout.plane = SCREEN_PLANE
	blackout.screen_loc = "CENTER"
	blackout.icon = 'icons/images/barrier.dmi'
	blackout.icon_state = ""
	blackout.color = BLACK
	var/matrix/M = matrix()
	M.Scale(SCREEN_BARRIER_SIZE)
	blackout.transform = M

	// Add it to client.
	blackout.alpha = 0
	blackout.mouse_opacity = 1
	client.screen += blackout

	// Fade it in.
	if(blackout)
		animate(blackout, alpha=255, time=delay)
	sleep(delay)
	if(blackout)
		blackout.mouse_opacity = 0
		if(client)
			client.screen -= blackout
		qdel(blackout)
