/obj/structure/thread
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
	var/raw_resource_type = /obj/item/stack/fibers
	var/product_resource_type = /obj/item/stack/thread
	var/production_cost_multiplier = 1
	var/production_amount = 5

/obj/structure/thread/UpdateIcon()
	UpdateThreadOverlay()
	..()

/obj/structure/thread/proc/UpdateThreadOverlay()
	overlays -= thread_overlay

	if(locate(raw_resource_type) in contains)
		thread_overlay = image(icon)
		if(in_use)
			thread_overlay.icon_state = "thread_spinning"
		else
			thread_overlay.icon_state = "thread"
		overlays += thread_overlay

/obj/structure/thread/ToggleOpen(var/mob/user, var/slot)
	return

/obj/structure/thread/ThingPutInside(var/obj/item/prop)
	..()
	UpdateThreadOverlay()

/obj/structure/thread/ThingTakenOut(var/obj/item/prop)
	..()
	UpdateThreadOverlay()

/obj/structure/thread/ManipulatedBy(var/mob/user, var/slot)
	. = ..()
	if(!. && !in_use)
		in_use = TRUE
		icon_state = "spinning"
		UpdateThreadOverlay()

		PlayLocalSound(src, 'sounds/effects/creak1.ogg', 100)
		NotifyNearby("<span class='notice'>\The [user] works at \the [src] for a few moments.</span>", MESSAGE_VISIBLE)

		if(DoAfterDelay(user, src, 12))
			for(var/thing in contains)
				if(!istype(thing, raw_resource_type))
					continue
				var/obj/item/stack/fibers = thing
				var/cost = max(1,(production_amount * production_cost_multiplier))
				if(fibers.GetAmount() < cost)
					user.Notify("There is not enough raw material in \the [src] to produce anything.")
					return
				new product_resource_type(get_turf(src), (fibers.material ? fibers.material.type : null), production_amount)
				fibers.Remove(cost)
				break
			icon_state = initial(icon_state)
			in_use = FALSE
			UpdateThreadOverlay()

		return TRUE

/obj/structure/thread/CanAcceptItem(var/obj/item/prop)
	return ..() && istype(prop, raw_resource_type) && prop.material && prop.material.spinnable

/obj/structure/thread/loom
	name = "loom"
	icon_state = "loom"
	icon = 'icons/objects/structures/loom.dmi'
	raw_resource_type = /obj/item/stack/thread
	product_resource_type = /obj/item/stack/thread/cloth
	production_cost_multiplier = 2
	flags = FLAG_SIMULATED | FLAG_ANCHORED