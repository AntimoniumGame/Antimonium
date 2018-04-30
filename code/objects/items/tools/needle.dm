/obj/item/needle
	name = "needle"
	icon = 'icons/objects/items/needle.dmi'
	edged = TRUE
	attack_verbs = list("pokes","pricks","jabs")
	associated_skill = SKILL_TAILORING

	var/thread_amount = 5
	var/obj/item/stack/thread/threaded
	var/image/thread_overlay
	var/image/thread_overlay_inv

/obj/item/needle/GetContactArea()
	return 0.1 //poke

/obj/item/needle/proc/ConsumeThread()
	if(threaded)
		threaded.Remove(1)
		if(!threaded || threaded.GetAmount() <= 0)
			threaded = null // thread handles deleting itself in Remove().
			UpdateIcon()

/obj/item/needle/GetInvIcon()
	var/image/I = ..()
	if(thread_overlay_inv)
		I.overlays += thread_overlay_inv
	return I

/obj/item/needle/UpdateIcon()

	if(thread_overlay)
		overlays -= thread_overlay

	var/thread_icon = 'icons/objects/items/thread/thread_grey.dmi'
	if(threaded)
		if(threaded.dyed)
			thread_icon = threaded.colour_to_icon[threaded.dyed]
		thread_overlay_inv = image(icon = thread_icon, icon_state = "needle")
		thread_overlay = image(icon = thread_icon, icon_state = "needle_world")
	else
		thread_overlay_inv = null
		thread_overlay = null

	..()

	if(threaded)
		overlays += thread_overlay

/obj/item/needle/Use(var/mob/user)
	if(threaded)
		threaded.ForceMove(get_turf(user))
		threaded = null
		UpdateIcon()
		return TRUE
	. = ..()

/obj/item/needle/AttackedBy(var/mob/user, var/obj/item/prop)
	var/obj/item/stack/thread/thread = prop
	if(istype(thread) && thread.is_thread)
		if(threaded)
			user.Notify("<span class='warning'>\The [src] is already threaded.</span>")
			return TRUE
		if(thread.GetAmount() < thread_amount)
			user.Notify("<span class='warning'>You need at least 5 strands to thread this needle.</span>")
			return TRUE
		threaded = new thread.type(src, thread.material.type, thread_amount)
		threaded.dyed = thread.dyed
		user.Notify("You thread \the [src] with some of \the [thread].", MESSAGE_VISIBLE)
		thread.Remove(thread_amount)
		UpdateIcon()
		return TRUE
	. = ..()
