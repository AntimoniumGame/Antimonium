/obj/item/needle
	name = "needle"
	icon = 'icons/objects/items/needle.dmi'
	sharpness = 3
	attack_verbs = list("pokes","pricks","jabs")
	associated_skill = SKILL_TAILORING

	var/obj/item/stack/thread/threaded
	var/image/thread_overlay
	var/image/thread_overlay_inv

/obj/item/needle/GetInvIcon()
	var/image/I = ..()
	if(thread_overlay_inv)
		I.overlays += thread_overlay_inv
	return I

/obj/item/needle/UpdateIcon()
	if(thread_overlay)
		overlays -= thread_overlay
	..()
	if(threaded)
		var/thread_icon = (threaded.dyed ? threaded.colour_to_icon[threaded.dyed] : 'icons/objects/items/thread/thread_grey.dmi')
		thread_overlay = image(icon = thread_icon, icon_state = "needle_world")
		thread_overlay_inv = image(icon = thread_icon, icon_state = "needle")
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
		if(thread.GetAmount() < 3)
			user.Notify("<span class='warning'>You need at least 3 strands to thread this needle.</span>")
			return TRUE
		threaded = new thread.type(src, thread.material.type, 3)
		threaded.dyed = thread.dyed
		user.Notify("You thread \the [src] with some of \the [thread].")
		thread.Remove(3)
		UpdateIcon()
		return TRUE
	. = ..()
