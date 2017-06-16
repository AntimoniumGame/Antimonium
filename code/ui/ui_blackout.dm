/obj/ui/blackout
	name = "darkness"
	screen_loc = "CENTER"
	icon = 'icons/images/barrier.dmi'
	icon_state = ""
	color = BLACK
	layer = 2 // Under the rest of the UI, but over the game world.
	mouse_opacity = 0

/obj/ui/blackout/Center(var/view_x, var/view_y)
	var/matrix/M = matrix()
	screen_loc = "[round(view_x/2)],[round(view_y/2)]"
	M.Scale(view_x+2, view_y+2)
	transform = M
