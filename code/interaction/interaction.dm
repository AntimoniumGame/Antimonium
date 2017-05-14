// Entry point for the click resolution chain.
/client/Click(object,location,control,params)
	if(world.time > next_click)
		next_click = world.time + 1
		var/modifiers = params2list(params)

		if(modifiers["middle"])
			mob.middle_click_on(object, modifiers["ctrl"], modifiers["alt"])
		else if(modifiers["left"])
			mob.left_click_on(object, modifiers["ctrl"], modifiers["alt"])
		else if(modifiers["right"])
			mob.right_click_on(object, modifiers["ctrl"], modifiers["alt"])
