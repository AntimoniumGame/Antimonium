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

/mob/animal/GetSlotByHandedness(var/handedness)
	return SLOT_MOUTH

/mob/animal/New()
	icon = null
	..()

/mob/animal/UpdateGrasp()
	var/obj/item/holding = GetEquipped(SLOT_MOUTH)
	if(istype(holding) && holding.Burn(src, SLOT_HEAD))
		Notify("\The [holding] sears your mouth and falls from your grasp!")
		DropItem(holding)

/mob/animal/IsDigger(var/complex_digging = FALSE)
	return !complex_digging
