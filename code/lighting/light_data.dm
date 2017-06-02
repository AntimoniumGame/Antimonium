/render_plane
	parent_type = /atom/movable
	appearance_flags = PLANE_MASTER | NO_CLIENT_COLOR
	screen_loc = "CENTER"

/render_plane/New(loc, new_plane, blending, clickable = 1)
	..()
	plane = new_plane
	blend_mode = blending
	mouse_opacity = clickable

/light_data
	var/color = "#FFF"
	var/temperature = 6500
	var/brightness = 100
	var/range = 3

/light_data/New(ntemp = 6500, nbright = 100, nrange = 3)
	temperature = ntemp
	brightness = nbright
	range = nrange
	UpdateColor()

/light_data/proc/GetColor()
	return color

/light_data/proc/SetColor(var/new_color)
	return

/light_data/proc/SetTemperature(var/new_temp)
	temperature = new_temp
	UpdateColor()

/light_data/proc/SetBrightness(var/new_bright)
	brightness = new_bright
	UpdateColor()

/light_data/proc/UpdateColor()
	color = ConvertTemperatureToRGB(temperature, brightness)

/light_data/effect/New(nrgb = "#FFF", nrange = 3, ntemp = 6500, nbright = 100)
	color = nrgb
	range = nrange
	temperature = ntemp
	brightness = nbright

/light_data/effect/SetColor(var/new_color)
	color = new_color
	UpdateColor()

//effect lights take rgb values directly
/light_data/effect/UpdateColor()
	return

/light_data/proc/ConvertToEffect()
	var/light_data/effect/E = new(color, range, temperature, brightness)
	return E

/light_data/effect/proc/ConvertToLight()
	var/light_data/L = new(temperature, brightness, range)
	return L

//works best between 1000K and 40000K (6600K is white)
// returns an RGB html string i.e. #ffef0b
/proc/ConvertTemperatureToRGB(temperature, brightness = 100)
	temperature /= 100
	brightness /= 100
	var/red
	var/green
	var/blue

	if(temperature <= 66)
		red = 255
	else
		red = temperature - 60
		red = 329.698727446 * (red ** -0.1332047592)
		red = Clamp(red, 0, 255)

	if(temperature <= 66)
		green = temperature
		green = 99.4708025861 * log(green) - 161.1195681661
		green = Clamp(green, 0, 255)
	else
		green = temperature - 60
		green = 288.1221695283 * (green ** -0.0755148492)
		green = Clamp(green, 0, 255)

	if(temperature >= 66)
		blue = 255
	else
		if(temperature <= 19)
			blue = 0
		else
			blue = temperature - 10
			blue = 138.5177312231 * log(blue) - 305.0447927307
			blue = Clamp(blue, 0, 255)

	return rgb(red * brightness, green * brightness, blue * brightness)

/proc/CreateLightOverlay(nicon, nicon_state, ndir, nplane, nlayer, nblend_mode, npixel)
	var/image/light_overlay = image(nicon, null, nicon_state, nlayer, ndir)
	light_overlay.plane = nplane
	light_overlay.blend_mode = nblend_mode
	light_overlay.pixel_x = light_overlay.pixel_y = npixel
	return light_overlay
