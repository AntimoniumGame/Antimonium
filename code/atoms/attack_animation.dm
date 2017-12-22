/atom/movable/proc/DoAttackAnimation(var/atom/A, var/obj/item/attacking_with)

	set waitfor = 0

	var/xdiff = 0
	var/ydiff = 0
	var/direction = get_dir(src, A)

	if(direction & NORTH)
		ydiff = 8
	else if(direction & SOUTH)
		ydiff = -8
	if(direction & EAST)
		xdiff = 8
	else if(direction & WEST)
		xdiff = -8

	var/last_pixel_x = pixel_x
	var/last_pixel_y = pixel_y
	animate(src, pixel_x = pixel_x + xdiff, pixel_y = pixel_y + ydiff, time = 2)
	animate(pixel_x = last_pixel_x, pixel_y = last_pixel_y, time = 2)

	if(istype(attacking_with))
		var/obj/effect/effect = new(get_turf(src))
		effect.overlays += attacking_with.GetInvIcon()
		effect.alpha = 220
		effect.pixel_x = xdiff*2
		effect.pixel_y = ydiff*2
		animate(effect, alpha = 0, pixel_x = xdiff*4, pixel_y = ydiff*4, pixel_z = 0, time = 3)
		sleep(3)
		QDel(effect, "end of attack anim")