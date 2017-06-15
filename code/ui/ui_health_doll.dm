/obj/ui/health
	name = "Health"
	screen_loc = "4,1"
	icon = 'icons/images/ui_doll.dmi'
	icon_state = "underlay_health"

	var/list/limb_overlays

/obj/ui/health/UpdateIcon()
	overlays -= limb_overlays

	limb_overlays = list()

	for(var/limb_tag in owner.limbs)
		var/obj/item/limb/limb = owner.GetLimb(limb_tag)
		var/limb_icon = limb.broken ? "[limb_tag]-broken" : limb_tag
		var/image/I = image(icon = src.icon, icon_state = limb_icon)
		switch(limb.pain)
			if(75 to 100)
				I.color = DARK_RED
			if(50 to 75)
				I.color = DARK_BROWN
			if(25 to 50)
				I.color = BROWN_ORANGE
			if(1 to 25)
				I.color = BROWN_GREEN
			else
				I.color = DARK_GREEN
		limb_overlays += I

	overlays += limb_overlays
