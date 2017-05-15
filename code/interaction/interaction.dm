// Entry point for the click resolution chain.
/client/Click(object,location,control,params)
	if(world.time > next_click)
		next_click = world.time + 1
		interface.on_click(object, location, control, params)
