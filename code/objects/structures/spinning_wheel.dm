/obj/structure/spinning_wheel
	name = "spinning wheel"
	icon = 'icons/objects/structures/spinning_wheel.dmi'
	icon_state = "wheel"
	density = 1
	weight = 5
	default_material_path = /datum/material/wood

	max_contains_count = 1
	max_contains_size_single = 20
	max_contains_size_total =  20
	open = TRUE

	var/in_use = FALSE
	var/image/thread_overlay	// overlay of the thread on the spinning wheel

/obj/structure/spinning_wheel/UpdateIcon()
	UpdateThreadOverlay()
	..()

/obj/structure/spinning_wheel/proc/UpdateThreadOverlay()
	overlays -= thread_overlay

	if(locate(/obj/item/stack/fibers) in contains)
		thread_overlay = image(icon)
		if(in_use)
			thread_overlay.icon_state = "thread_spinning"
		else
			thread_overlay.icon_state = "thread"
		overlays += thread_overlay

/obj/structure/spinning_wheel/ToggleOpen(var/mob/user, var/slot)
	return

/obj/structure/spinning_wheel/ThingPutInside(var/obj/item/prop)
	..()
	UpdateThreadOverlay()

/obj/structure/spinning_wheel/ThingTakenOut(var/obj/item/prop)
	..()
	UpdateThreadOverlay()

/obj/structure/spinning_wheel/ManipulatedBy(var/mob/user, var/slot)
	. = ..()
	if(!. && !in_use)
		in_use = TRUE
		icon_state = "spinning"
		UpdateThreadOverlay()

		PlayLocalSound(src, 'sounds/effects/creak1.ogg', 100)
		NotifyNearby("<span class='notice'>\The [user] works at \the [src] for a few moments.</span>")

		spawn(12)
			for(var/obj/item/stack/fibers/fibers in contains)
				var/using = min(5,fibers.GetAmount())
				new /obj/item/stack/thread(get_turf(src), (fibers.material ? fibers.material.type : null), using)
				fibers.Remove(using)
				break
			icon_state = "wheel"
			in_use = FALSE
			UpdateThreadOverlay()

		return TRUE

/obj/structure/spinning_wheel/CanAcceptItem(var/obj/item/prop)
	return ..() && istype(prop, /obj/item/stack/fibers) && prop.material && prop.material.spinnable
