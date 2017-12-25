/obj/item/vessel
	name = "beaker"
	icon = 'icons/objects/items/vessel.dmi'
	flags = FLAG_SIMULATED | FLAG_IS_EDIBLE | FLAG_THROWN_SPIN
	max_reagent_volume = 5
	precise_reagent_transfer = TRUE

	var/image/world_overlay
	var/image/held_overlay

/obj/item/vessel/GetInvIcon()
	var/image/I = ..()
	if(held_overlay)
		I.overlays += held_overlay
	return I

/obj/item/vessel/UpdateIcon()
	if(world_overlay)
		overlays -= world_overlay
	UpdateOverlays()
	..()
	if(world_overlay)
		overlays += world_overlay

/obj/item/vessel/proc/UpdateOverlays()
	var/vessel_contents = 0
	var/list/colours_to_mix = list()
	for(var/thing in contains_reagents)
		var/obj/item/prop = thing
		vessel_contents += prop.GetAmount()
		colours_to_mix += prop.material ? prop.material.colour : WHITE

	if(!vessel_contents || !colours_to_mix)
		world_overlay = null
		held_overlay = null
		return

	var/index = 1
	if(vessel_contents >= max_reagent_volume)
		index = max_reagent_volume
	else
		index = max(1, min(max_reagent_volume, round(max_reagent_volume * (vessel_contents/max_reagent_volume))))
	held_overlay = image(icon = icon, icon_state = "underlay-[index]")
	world_overlay = image(icon = icon, icon_state = "underlay-world")

	//TODO: RGB mixing
	var/use_color = pick(colours_to_mix)
	held_overlay.color = use_color
	world_overlay.color = use_color

/obj/item/vessel/Eaten(var/mob/user)

	var/obj/item/organ/stomach = user.GetHealthyOrganByKey(ORGAN_STOMACH)
	if(!stomach)
		user.Notify("<span class='warning'>You are not currently capable of drinking.</span>")
		return TRUE

	if(!contains_reagents.len)
		user.Notify("<span class='warning'>\The [src] is empty.</span>")
		return TRUE

	var/obj/item/drinking = pick(contains_reagents)
	user.AddEffect(/datum/effect/consumed_reagent, drinking.material.GetName(), drinking.GetAmount()*50, drinking.material)
	QDel(drinking, "drunk")

	if(contains_reagents.len)
		user.NotifyNearby("\The [user] takes a swig from \the [src].")
	else
		user.NotifyNearby("\The [user] drains the dregs of \the [src].")
	UpdateIcon()
	return TRUE
