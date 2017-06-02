/client/proc/RunLightTool()

	set name = "Lighting Tool"
	set category = "Tools"

	if(CheckAdminPermission(PERMISSIONS_DEBUG))
		winset(src, "lighttoolwindow", "is-visible=true")

/client/proc/LightToolPick()

	set hidden = 1

	if(CheckAdminPermission(PERMISSIONS_DEBUG))
		interface = new /interface/lighttool(src)

/client/proc/LightToolMode(params as text)

	set hidden = 1

	if(CheckAdminPermission(PERMISSIONS_DEBUG))
		var/list/param_list = params2list(params)
		var/atom/A = locate(param_list["ref"])
		if(istype(A))
			LightModeSwitch(A)

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
			L.SetTemperature(floor((input_value * 140) + 1000)) // 1000K minimum, 15000K maximum
		if("brightness")
			L.SetBrightness(floor(input_value))
		if("range")
			L.range = floor((input_value / 100) * MAX_LIGHT_RANGE)

	UpdateLightingTool(L, "\ref[A]")
	A.UpdateLight()

/client/proc/LightModeSwitch(var/atom/A)
	var/light_data/L = A.GetLight()
	if(istype(L))
		switch(L.type)
			if(/light_data)
				A.SetLight(L.ConvertToEffect())
			if(/light_data/effect)
				var/light_data/effect/E = L
				A.SetLight(E.ConvertToLight())

		UpdateLightingTool(A.GetLight(), "\ref[A]")

/client/proc/PickLighttoolSource(var/atom/A)
	set waitfor = 0
	if(istype(A))
		winset(src, "lighttoolwindow.lt_selected_light", "text=\"[A] ([A.type])\"")
		winset(src, "lighttoolwindow.lt_mode_btn", "command=\"LightToolMode ref=\ref[A]\"")

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

/client/proc/LightToolSetRGB(params as text)

	set hidden = 1

	var/list/param_list = params2list(params)
	var/atom/A = locate(param_list["ref"])
	if(istype(A))
		var/light_data/L = A.GetLight()
		if(istype(L))
			var/new_color = input("Select color:", "RGB Light Colour Picker", L.GetColor()) as color
			L.SetColor(new_color)
			A.UpdateLight()
			UpdateLightingTool(L, "\ref[A]")

/client/proc/UpdateLightingTool(var/light_data/light, ref)
	if(!light)
		light = new()

	//setting value on a slider calls on-change and creates a loop, so we disable them before updating the interface
	winset(src, "lighttoolwindow.lt_clr_sld", "on-change=")
	winset(src, "lighttoolwindow.lt_brt_sld", "on-change=")
	winset(src, "lighttoolwindow.lt_rng_sld", "on-change=")

	winset(src, "lighttoolwindow.lt_clr_in", "command=")
	winset(src, "lighttoolwindow.lt_brt_in", "command=")
	winset(src, "lighttoolwindow.lt_rng_in", "command=")

	switch(light.type)
		if(/light_data)
			winset(src, "lighttoolwindow.lt_mode_btn", "text=\"Mode: Real\"")
			winset(src, "lighttoolwindow.lt_rgb_btn", "text=;command=;is-flat=true;is-disabled=true")

			winset(src, "lighttoolwindow.lt_col_lbl", "text=\"   Colour:\"")
			winset(src, "lighttoolwindow.lt_brt_lbl", "text=\"   Brightness:\"")

			winset(src, "lighttoolwindow.lt_clr_out", "text=[light.temperature]K")
			winset(src, "lighttoolwindow.lt_clr_in", "text=[light.temperature];is-disabled=false")
			winset(src, "lighttoolwindow.lt_clr_sld", "value=[(light.temperature - 1000) / 140];is-disabled=false")

			winset(src, "lighttoolwindow.lt_brt_out", "text=[light.brightness]")
			winset(src, "lighttoolwindow.lt_brt_in", "text=[light.brightness];is-disabled=false")
			winset(src, "lighttoolwindow.lt_brt_sld", "value=[light.brightness];is-disabled=false")

			//we reenable on-change for the color and brightness sliders only for normal mode
			winset(src, "lighttoolwindow.lt_clr_sld", "on-change=\"LightToolChange ref=[ref];mode=color;value=\[\[*\]\]\"")
			winset(src, "lighttoolwindow.lt_brt_sld", "on-change=\"LightToolChange ref=[ref];mode=brightness;value=\[\[*\]\]\"")

			winset(src, "lighttoolwindow.lt_clr_in", "command=\"LightToolChange ref=[ref];mode=color;input=1;value=\"")
			winset(src, "lighttoolwindow.lt_brt_in", "command=\"LightToolChange ref=[ref];mode=brightness;value=\"")

		if(/light_data/effect)
			winset(src, "lighttoolwindow.lt_mode_btn", "text=\"Mode: RGB\"")
			winset(src, "lighttoolwindow.lt_rgb_btn", "text=\"RGB Selection\";command=\"LightToolSetRGB ref=[ref]\";is-flat=false;is-disabled=false")

			winset(src, "lighttoolwindow.lt_clr_in", "is-disabled=true")
			winset(src, "lighttoolwindow.lt_clr_sld", "is-disabled=true")
			winset(src, "lighttoolwindow.lt_brt_in", "is-disabled=true")
			winset(src, "lighttoolwindow.lt_brt_sld", "is-disabled=true")


	winset(src, "lighttoolwindow.lt_color_sample", "background-color=[light.color]")

	winset(src, "lighttoolwindow.lt_rng_out", "text=[light.range]")
	winset(src, "lighttoolwindow.lt_rng_in", "text=[light.range]")
	winset(src, "lighttoolwindow.lt_rng_sld", "value=[light.range / MAX_LIGHT_RANGE * 100]")

	//we reenable the range slider for both modes
	winset(src, "lighttoolwindow.lt_rng_sld", "on-change=\"LightToolChange ref=[ref];mode=range;value=\[\[*\]\]\"")
	winset(src, "lighttoolwindow.lt_rng_in", "command=\"LightToolChange ref=[ref];mode=range;input=1;value=\"")

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
