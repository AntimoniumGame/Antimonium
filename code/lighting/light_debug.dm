/client/proc/RunLightTool()

	set name = "Lighting Tool"
	set category = "Tools"

	if(CheckAdminPermission(PERMISSIONS_DEBUG))
		winset(src, "lighttoolwindow", "is-visible=true")

/client/proc/LightToolPick()

	set hidden = 1

	if(CheckAdminPermission(PERMISSIONS_DEBUG))
		interface = new /interface/lighttool(src)

/client/proc/LightToolChange(params as text)

	set hidden = 1

	var/list/param_list = params2list(params)
	var/input_value
	if(param_list["input"])
		switch(param_list["mode"])
			if("color")
				input_value = (Clamp(text2num(param_list["value"]), 1000, 15000) - 1000) / 140
			if("range")
				input_value = text2num(param_list["value"]) / MAX_LIGHT_RANGE * 100
	else
		input_value = text2num(param_list["value"])

	var/atom/A = locate(param_list["ref"])
	if(!A)
		return

	var/light_data/L = A.GetLight()
	if(!L)
		return

	switch(param_list["mode"])
		if("color")
			L.temperature = floor((input_value * 140) + 1000) // 1000K minimum, 15000K maximum
			L.UpdateColor()
		if("brightness")
			L.brightness = floor(input_value)
			L.UpdateColor()
		if("range")
			L.range = floor((input_value / 100) * MAX_LIGHT_RANGE)

	UpdateLightingTool(L, "\ref[A]")
	A.UpdateLight()

/client/proc/PickLighttoolSource(var/atom/A)
	set waitfor = 0
	if(istype(A))
		winset(src, "lighttoolwindow.lt_selected_light", "text=\"[A] ([A.type])\"")

		winset(src, "lighttoolwindow.lt_clr_sld", "on-change=\"LightToolChange ref=\ref[A];mode=color;value=\[\[*\]\]\"")
		winset(src, "lighttoolwindow.lt_brt_sld", "on-change=\"LightToolChange ref=\ref[A];mode=brightness;value=\[\[*\]\]\"")
		winset(src, "lighttoolwindow.lt_rng_sld", "on-change=\"LightToolChange ref=\ref[A];mode=range;value=\[\[*\]\]\"")

		winset(src, "lighttoolwindow.lt_clr_in", "command=\"LightToolChange ref=\ref[A];mode=color;input=1;value=\"")
		winset(src, "lighttoolwindow.lt_brt_in", "command=\"LightToolChange ref=\ref[A];mode=brightness;value=\"")
		winset(src, "lighttoolwindow.lt_rng_in", "command=\"LightToolChange ref=\ref[A];mode=range;input=1;value=\"")

		var/light_data/L = A.GetLight()
		if(istype(L))
			UpdateLightingTool(L, "\ref[A]")

	interface = new(src)

/client/proc/UpdateLightingTool(var/light_data/light, ref)
	if(!light)
		light = new()

	//setting value on a slider calls on-change and creates a loop, so we disable them before updating the interface
	winset(src, "lighttoolwindow.lt_clr_sld", "on-change=")
	winset(src, "lighttoolwindow.lt_brt_sld", "on-change=")
	winset(src, "lighttoolwindow.lt_rng_sld", "on-change=")

	winset(src, "lighttoolwindow.lt_clr_out", "text=[light.temperature]K")
	winset(src, "lighttoolwindow.lt_clr_in", "text=[light.temperature]")
	winset(src, "lighttoolwindow.lt_clr_sld", "value=[(light.temperature - 1000) / 140]")
	winset(src, "lighttoolwindow.lt_clr_out", "background-color=[ConvertTemperatureToRGB(light.temperature)]")

	winset(src, "lighttoolwindow.lt_brt_out", "text=[light.brightness]")
	winset(src, "lighttoolwindow.lt_brt_in", "text=[light.brightness]")
	winset(src, "lighttoolwindow.lt_brt_sld", "value=[light.brightness]")

	winset(src, "lighttoolwindow.lt_rng_out", "text=[light.range]")
	winset(src, "lighttoolwindow.lt_rng_in", "text=[light.range]")
	winset(src, "lighttoolwindow.lt_rng_sld", "value=[light.range / MAX_LIGHT_RANGE * 100]")

	//then we reenable on-change for the sliders
	winset(src, "lighttoolwindow.lt_clr_sld", "on-change=\"LightToolChange ref=[ref];mode=color;value=\[\[*\]\]\"")
	winset(src, "lighttoolwindow.lt_brt_sld", "on-change=\"LightToolChange ref=[ref];mode=brightness;value=\[\[*\]\]\"")
	winset(src, "lighttoolwindow.lt_rng_sld", "on-change=\"LightToolChange ref=[ref];mode=range;value=\[\[*\]\]\"")

//makes the master layer invisible and removes mob vision limiting factors so you can see the lighting plane in all its glory
/client/verb/debuglighting()
	set name = "Debug Lighting Plane"
	set category = "Debug"

	if(CheckAdminPermission(PERMISSIONS_DEBUG))
		if(master_plane)
			if(master_plane.alpha > 0)
				master_plane.alpha = 0
				if(mob && mob.vision_cone)
					mob.sight |= SEE_TURFS
					mob.sight &= ~SEE_BLACKNESS
					mob.vision_cone.plane = -100
			else
				master_plane.alpha = 255
				if(mob && mob.vision_cone)
					mob.sight |= SEE_BLACKNESS
					mob.sight &= ~SEE_TURFS
					mob.vision_cone.plane = VISION_PLANE
