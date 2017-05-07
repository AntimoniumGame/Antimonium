/mob/human
	name = "human"
	density = 1

/mob/human/New()
	..()
	create_limbs()
	update_icon()

/mob/clicked_on(var/thing)

	if(istype(thing, /obj/ui))
		var/obj/ui/clicked = thing
		clicked.clicked_on(src)
		return

	if(istype(thing, /obj/item))
		var/obj/item/clicked = thing
		if(is_adjacent_to(clicked))
			collect_item(clicked)
		else
			notify("You are too far away from \the [clicked].")
