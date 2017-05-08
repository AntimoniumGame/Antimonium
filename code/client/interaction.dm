/client
	show_popup_menus = 0 // So that right-click is passed to Click() properly.
	var/next_click = 0

/client/Click(object,location,control,params)
	if(world.time > next_click)
		next_click = world.time + 2
		var/modifiers = params2list(params)
		if(modifiers["middle"])
			mob.middle_click_on(object)
		else if(modifiers["left"])
			mob.left_click_on(object)
		else if(modifiers["right"])
			mob.right_click_on(object)
