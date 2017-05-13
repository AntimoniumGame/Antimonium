/obj/ui/doll/health
	name = "Health"
	screen_loc = "4,1"
	icon_state = "underlay_health"
	var/mob/human/human_owner

/obj/ui/doll/health/New(var/mob/_owner)
	human_owner = _owner
	..(_owner)

/obj/ui/doll/health/update_icon()
	var/list/limb_overlays = list()
	for(var/limb_tag in human_owner.limbs)
		var/obj/item/limb/limb = human_owner.limbs[limb_tag]
		var/limb_icon = limb.broken ? "[limb_tag]-broken" : limb_tag
		var/image/I = image(icon = src.icon, icon_state = limb_icon)
		I.alpha = 90
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
				I.color = PALE_GREEN
		limb_overlays += I
	overlays = limb_overlays