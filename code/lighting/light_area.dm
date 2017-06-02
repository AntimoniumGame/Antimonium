/area
	plane = UI_PLANE
	var/light_data/light
	var/image/light_overlay
	var/list/lighting_blend_turfs

/area/New()
	..()
	icon = null
	plane = LIGHTING_PLANE
	lighting_blend_turfs = list()
	if(!light)
		light = new()
	CreateLight()

/area/UpdateIcon()
	return

/area/CreateLight()
	light_overlay = image('icons/lighting/blackness.dmi')
	light_overlay.plane = LIGHTING_PLANE
	light_overlay.layer = LIGHT_LAYER_AREA
	light_overlay.blend_mode = BLEND_ADD

	UpdateLight()

/area/UpdateLight()
	var/list/overlay_list = overlays
	overlay_list -= light_overlay // remove the light overlay before we modify it
	light_overlay.color = light.GetColor()
	overlay_list += light_overlay // add the light overlay back in
	overlays = overlay_list
	for(var/turf/T in lighting_blend_turfs)
		T.RefreshLighting()

/area/GetLight()
	return light

/area/proc/GetLightColor()
	if(istype(light))
		return light.GetColor()
	else
		return null

/area/SetLight(var/light_data/new_light)
	light = new_light
	UpdateLight()

/area/outdoors
	icon = 'icons/areas/areas.dmi'
	icon_state = "sky"

/area/outdoors/New()
	light = new(6500, 90) // sunlight yellow - 90% brightness
	..()

/area/indoors
	icon = 'icons/areas/areas.dmi'
	icon_state = "room"

/area/indoors/New()
	light = new(12000, 15) // pale blue - 15% brightness
	..()
