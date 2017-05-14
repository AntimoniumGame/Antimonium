/mob/human
	name = "human"
	density = 1
	icon = 'icons/mobs/human_full.dmi'

/mob/human/New()
	..()
	icon = null
	create_limbs()
	update_icon()

/mob/human/proc/toggle_prone()
	prone = !prone
	density = !prone
	update_icon()

/mob/human/die(var/message)
	. = ..(message)
	if(. && !prone)
		toggle_prone()

/mob/human/update_strings()
	..()
	if(key)
		name = key
