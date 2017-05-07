/mob/verb/testlights()

	set name = "Toggle Self Light"
	set category = "Debug"

	light_power = 10
	light_range = 5
	light_color = WHITE
	light_type = LIGHT_SOFT

	if(light_obj)
		notify("Killed self light.")
		kill_light()
	else
		notify("Set self light.")
		set_light()

	sleep(5)
	if(light_obj)
		light_obj.follow_holder()