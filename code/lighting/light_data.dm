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

/light_data/proc/UpdateColor()
	color = ConvertTemperatureToRGB(temperature, brightness)

/light_data/effect/New(nrgb = "#FFF", nrange = 3, ntemp = 6500, nbright = 100)
	color = nrgb
	range = nrange
	temperature = ntemp
	brightness = nbright

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
/*
/proc/ConvertHueToRGB(hue, brightness = 100)
	hue = floor(hue)
	brightness /= 100

	var/red, green, blue = 0

	switch(hue)
		if(0 to 60)
			red = 255
			green = hue / 60 * 255
			blue = 0
		if(61 to 120)
			red = abs((hue - 60) / 60 - 1) * 255
			green = 255
			blue = 0
		if(121 to 180)
			red = 0
			green = 255
			blue = (hue - 120) / 60 * 255
		if(181 to 240)
			red = 0
			green = abs((hue - 180) / 60 - 1) * 255
			blue = 255
		if(241 to 300)
			red = (hue - 240) / 60 * 255
			green = 0
			blue = 255
		if(301 to 360)
			red = 255
			green = 0
			blue = abs((hue - 300) / 60 - 1) * 255

	return rgb(red * brightness, green * brightness, blue * brightness)
*/
