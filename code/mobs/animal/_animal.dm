/mob/animal
	name = "dog"
	understand_category = "dog"
	mob_overlay_ident = "dog"

/mob/animal/DoViolentUnarmedInteraction(var/mob/target)
	NotifyNearby("\The [src] mauls \the [target]!")
	PlayLocalSound(src, 'sounds/effects/bork1.ogg', 50, frequency = -1)
	target.ResolvePhysicalAttack(src, 8, 5, 5, null)

/mob/animal/DoPassiveUnarmedInteraction(var/mob/target)
	NotifyNearby("\The [src] sniffs curiously at \the [target].")

/mob/animal/ScrambleSpeech(var/message)
	return "barks!"

/mob/animal/New()
	icon = null
	..()
