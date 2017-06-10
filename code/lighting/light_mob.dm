//mobs can inherit a light overlay from another object (ideally an object in their possesion)
/mob
	var/list/light_overlays

/mob/proc/InheritLight(var/light_data/light)
	if(!light)
		return
	if(!light_overlays)
		light_overlays = list()

	var/list/overlay_list = overlays

	var/image/light_overlay = CreateLightOverlayFromData(light) // we create a new overlay that doesn't have shadows
	light_overlays[light] = light_overlay

	overlay_list += light_overlay
	overlays = overlay_list

/mob/proc/RemoveLight(var/light_data/light)
	if(!light || !light_overlays[light]) // this isn't the overlay we are looking for
		return

	var/list/overlay_list = overlays

	var/image/light_overlay = light_overlays[light]
	light_overlays[light] = null

	overlay_list -= light_overlay
	overlays = overlay_list
/*
/mob/UpdateLight(var/light_data/light)
	if(!light || !light_overlays[light])
		return
*/

/mob/proc/LightOn(var/light_data/light)
	if(!light || !light_overlays[light]) // this isn't the overlay we are looking for
		return

	var/list/overlay_list = overlays
	var/image/light_overlay = light_overlays[light]
	overlay_list -= light_overlay

	light_overlay.alpha = 255

	overlay_list += light_overlay
	overlays = overlay_list

/mob/proc/LightOff(var/light_data/light)
	if(!light || !light_overlays[light]) // this isn't the overlay we are looking for
		return

	var/list/overlay_list = overlays
	var/image/light_overlay = light_overlays[light]
	overlay_list -= light_overlay

	light_overlay.alpha = 0

	overlay_list += light_overlay
	overlays = overlay_list
