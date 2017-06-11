/obj/ui/meter
	name = "meter"
	icon = 'icons/images/ui_meter.dmi'
	icon_state = "underlay"
	screen_loc = "CENTER, CENTER"

	var/image/caption_icon
	var/image/meter
	var/image/mask

	var/offset
	var/last_value
	var/current_value = 0
	var/max_value = 100
	var/meter_size = 128

/obj/ui/meter/New(var/mob/_owner, var/_caption_icon = "hunger", var/_offset = 1)
	meter = image(icon = icon, icon_state = "overlay")
	meter.appearance_flags = PIXEL_SCALE
	mask = image(icon = icon, icon_state = "mask")
	caption_icon = image(icon = 'icons/images/ui_meter_captions.dmi', icon_state = _caption_icon)
	caption_icon.pixel_x = -9
	overlays += caption_icon
	UpdateMeter()
	offset = _offset
	..(_owner)

/obj/ui/meter/Center(var/view_x, var/view_y)
	if(!isnull(offset) && offset != 0)
		screen_loc = "1:16,[view_y+1]:[offset*-9]"
	else
		screen_loc = "1:16,[view_y+1]"

/obj/ui/meter/UpdateIcon()
	UpdateMeter()
	..()

/obj/ui/meter/proc/UpdateMeter(var/_value)

	if(!isnull(_value))
		current_value = _value

	var/remaining = current_value / max_value
	if(remaining == last_value)
		return
	last_value = remaining

	overlays -= meter
	overlays -= mask

	if(remaining == 1)
		animate(meter, transform = matrix(), color = GetMeterColor(), time = 8)
	else
		var/matrix/M = matrix()
		M.Scale(remaining,1)
		M.Translate(-(round((meter_size-(meter_size * remaining))/2)),0)
		animate(meter, transform = M, color = GetMeterColor(), time = 8)

	overlays += meter
	overlays += mask

/obj/ui/meter/proc/GetMeterColor()
	switch((current_value / max_value)*100)
		if(75 to 100)
			return PALE_GREEN
		if(50 to 75)
			return BRIGHT_YELLOW
		if(25 to 50)
			return BRIGHT_ORANGE
	return DARK_RED
