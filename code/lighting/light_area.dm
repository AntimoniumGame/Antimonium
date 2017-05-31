/area
	var/light_data/light
	var/image/light_overlay
	var/list/lighting_blend_turfs

/area/New()
	..()
	lighting_blend_turfs = list()
	if(!light)
		light = new()
	CreateLight()

/area/UpdateIcon()
	return

/area/CreateLight()
	light_overlay = new()
	light_overlay.icon = 'icons/lighting/blackness.dmi'
	light_overlay.plane = LIGHTING_PLANE
	light_overlay.layer = LIGHT_LAYER_AREA
	light_overlay.blend_mode = BLEND_ADD

	UpdateLight()

/area/UpdateLight()
	var/list/overlay_list = overlays
	overlay_list -= light_overlay // remove the light overlay before we modify it
	light_overlay.color = light.color
	overlay_list += light_overlay // add the light overlay back in
	overlays = overlay_list
	for(var/turf/T in lighting_blend_turfs)
		T.RefreshLighting()

/area/GetLight()
	return light

/area/outdoors/New()
	light = new(6500, 90) // sunlight yellow - 90% brightness
	..()

/area/indoors/New()
	light = new(12000, 15) // pale blue - 15% brightness
	..()
