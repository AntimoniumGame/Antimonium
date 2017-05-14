/mob/animal
	name = "dog"
	understand_category = "dog"
	mob_overlay_ident = "dog"

/mob/animal/do_violent_unarmed_interaction(var/mob/target)
	notify_nearby("\The [src] mauls \the [target]!")
	play_local_sound(src, 'sounds/effects/bork1.ogg', 50, frequency = -1)
	target.resolve_physical_attack(src, 8, 5, 5, null)

/mob/animal/do_passive_unarmed_interaction(var/mob/target)
	notify_nearby("\The [src] sniffs curiously at \the [target].")

/mob/animal/scramble_speech(var/message)
	return "barks!"

/mob/animal/New()
	icon = null
	..()
