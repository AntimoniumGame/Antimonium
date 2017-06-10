//objects can cast light
/obj
	var/light_data/light
	var/image/light_overlay

/obj/proc/LightOn()
	if(!light || !light_overlay)
		UpdateLight()

	var/list/overlay_list = overlays
	overlay_list -= light_overlay

	light_overlay.alpha = 255

	overlay_list += light_overlay
	overlays = overlay_list

	if(istype(loc, /mob))
		var/mob/holder = loc
		holder.LightOn(light)

/obj/proc/LightOff()
	if(!light_overlay)
		return

	var/list/overlay_list = overlays
	overlay_list -= light_overlay

	light_overlay.alpha = 0

	overlay_list += light_overlay
	overlays = overlay_list

	if(istype(loc, /mob))
		var/mob/holder = loc
		holder.LightOff(light)

/obj/GetLight()
	if(!light)
		light = new()
	return light

/obj/UpdateLight()
	if(!light || !light_overlay)
		CreateLight()

	var/list/overlay_list = overlays
	overlay_list -= light_overlay // remove the light overlay before we modify it

	light_overlay.color = light.GetColor()

	overlay_list += light_overlay // add the light overlay back in
	overlays = overlay_list

/obj/CreateLight()
	if(!light)
		light = new()
		light_overlay = null
	if(!light_overlay)
		light_overlay = CreateLightOverlayFromData(light)

/obj/SetLight(var/light_data/new_light)
	if(!new_light)
		return

	var/list/overlay_list = overlays
	overlay_list -= light_overlay

	light = new_light // overwrite the old light data
	light_overlay = null // null the overlay so it rebuilds
	UpdateLight() // update the light

/obj/UpdateRange()
	if(!light)
		return

	var/list/overlay_list = overlays
	overlay_list -= light_overlay // remove the light overlay before we modify it

	light_overlay = null
	UpdateLight()

/obj/proc/RemoveLight()
	LightOff()
	light = null
	light_overlay = null
