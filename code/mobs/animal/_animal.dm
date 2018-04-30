/mob/animal
	name = "animal"
	understand_category = "animal"
	flags = FLAG_FLAMMABLE | FLAG_SIMULATED | FLAG_THROWN_SPIN
	ideal_sight_value = 4
	draw_shadow_underlay = TRUE

/mob/animal/DoPassiveUnarmedInteraction(var/mob/target)
	NotifyNearby("\The [src] sniffs curiously at \the [target].", MESSAGE_VISIBLE)

/mob/animal/ScrambleSpeech(var/message)
	return "barks!"

/mob/animal/GetSlotByHandedness(var/handedness)
	return SLOT_MOUTH

/mob/animal/Initialize()
	icon = null
	..()

/mob/animal/UpdateGrasp()
	var/obj/item/holding = GetEquipped(SLOT_MOUTH)
	if(istype(holding) && holding.Burn(src, SLOT_FACE))
		Notify("\The [holding] sears your mouth and falls from your grasp!")
		DropItem(holding)

/mob/animal/IsDigger(var/complex_digging = FALSE)
	return !complex_digging
