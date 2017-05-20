// Mobs that do not have a physical presence or are
// otherwise not fully part of the game world.
/mob/abstract
	invisibility = INVISIBILITY_MAXIMUM
	flags = 0

/mob/abstract/CreateLimbs()
	return

/mob/abstract/TurnMob(var/newdir)
	return

/mob/abstract/NoDeadMove()
	return FALSE

/mob/abstract/GetMoveDelay()
	return 1

/mob/abstract/CreateUI()
	// This is simply to avoid a null intent selector runtime.
	intent = new(src) // It doesn't need to be tracked or accessible.

/mob/abstract/LeftClickOn(var/atom/thing, var/ctrl, var/alt)
	return

/mob/abstract/RightClickOn(var/atom/thing, var/ctrl, var/alt)
	return

/mob/abstract/MiddleClickOn(var/atom/thing, var/ctrl, var/alt)
	return

/mob/abstract/HandleLifeTick()
	return

/mob/abstract/ExaminedBy(var/mob/clicker)
	clicker.Notify("That's a spooky ghost!")

/mob/abstract/UpdateIcon()
	return
