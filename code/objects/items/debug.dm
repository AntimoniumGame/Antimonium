/obj/item/glowstick
	name = "glowstick"
	light_power = 5
	light_range = 3
	light_color = PALE_GREEN
	slot_flags = SLOT_FLAG_BACK

/obj/item/glowstick/use(var/mob/user)
	if(light_obj)
		kill_light()
	else
		set_light()
