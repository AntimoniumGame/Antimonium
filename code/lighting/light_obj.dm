//objects can cast light
/obj
	var/light_on = FALSE
	var/light_data/light
	var/image/light_overlay
/*
/obj/New()
	UpdateLight()
	. = ..()
*/
/obj/GetLight()
	if(!light)
		light = new()
	return light

/obj/CreateLight()
	world << "Creating light for [src]"
	if(!light_overlay)
		light_overlay = image('icons/lighting/light_range_3.dmi', null, "white")
	if(!light)
		light = new()
/*
	light_overlay.icon = 'icons/lighting/light_range_3.dmi'
	light_overlay.icon_state = "white"
	light_overlay.plane = LIGHTING_PLANE
	light_overlay.layer = LIGHT_LAYER_BASE
	light_overlay.blend_mode = BLEND_ADD
	light_overlay.appearance_flags = KEEP_TOGETHER
	light_overlay.pixel_x = -96
	light_overlay.pixel_y = -96
	var/image/I = image('icons/lighting/light_range_3.dmi', "overlay")
	I.plane = LIGHTING_PLANE
	I.blend_mode = BLEND_OVERLAY
	I.layer = LIGHT_LAYER_OVERLAY
	light_overlay.overlays += I
*/
	CreateLightOverlay(light_overlay, light)

	overlays += light_overlay

	UpdateLight()

/obj/UpdateLight()
	var/list/overlay_list = overlays
	overlay_list -= light_overlay // remove the light overlay before we modify it
	light_overlay.color = light.color
	if(!light_on)
		light_overlay.alpha = 0
	else
		light_overlay.alpha = light.brightness / 100 * 255

	overlay_list += light_overlay // add the light overlay back in
	overlays = overlay_list

/proc/CreateLightOverlay(var/image/overlay, var/light_data/light)
	if(!overlay || !light)
		return

	overlay.icon = 'icons/lighting/light_range_3.dmi'
	overlay.icon_state = "white"
	overlay.plane = LIGHTING_PLANE
	overlay.layer = LIGHT_LAYER_BASE
	overlay.blend_mode = BLEND_ADD
	overlay.appearance_flags = KEEP_TOGETHER
	overlay.pixel_x = overlay.pixel_y = -96

	var/image/I = image(overlay.icon, "overlay")
	I.plane = LIGHTING_PLANE
	I.layer = LIGHT_LAYER_OVERLAY
	I.blend_mode = BLEND_OVERLAY

	overlay.overlays += I
