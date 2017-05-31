/obj/structure/earthworks
	name = "earthworks"
	density = 0
	flags = FLAG_SIMULATED | FLAG_FLAT_SURFACE | FLAG_ANCHORED
	default_material_path = null

/obj/structure/earthworks/AttackedBy(var/mob/user, var/obj/item/prop)
	if(istype(prop, /obj/item/weapon/shovel))
		FillIn(user)
		return TRUE
	. = ..()

/obj/structure/earthworks/ManipulatedBy(var/mob/user, var/slot)
	if(user.IsDigger() && user.CanUseInvSlot(slot))
		FillIn(user)
		return TRUE
	. = ..()

/obj/structure/earthworks/proc/FillIn(var/mob/user)
	user.NotifyNearby("\The [user] fills in \the [src].")
	QDel(src)
