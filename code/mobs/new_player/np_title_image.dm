var/obj/title_image

/proc/get_title_image()
	if(!title_image)
		title_image = new /obj()
		title_image.icon = 'icons/images/title_image.dmi'
		title_image.plane = SCREEN_PLANE
		title_image.screen_loc = "CENTER,CENTER"
	return title_image
