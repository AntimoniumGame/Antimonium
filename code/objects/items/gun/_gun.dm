/obj/item/gun
	has_variant_inhand_icon = TRUE
	var/obj/item/shot/loaded
	var/loading
	var/fire_force = 75 // m/s
	var/load_time = 25

/obj/item/gun/New()
	..()
	loaded = new(src)

/obj/item/gun/proc/GetLoaded()
	. = loaded
	loaded = null

/obj/item/gun/FireAt(var/mob/user, var/atom/target)

	if(!istype(target) || !(istype(target, /turf) || istype(target.loc, /turf)))
		return FALSE

	var/obj/item/firing = GetLoaded()
	if(!istype(firing))
		if(IsAdjacentTo(user, target))
			return FALSE
		user.Notify("<span class='warning'>\The [src] clicks on an empty chamber.</span>")
		PlayLocalSound(user, 'sounds/effects/click2.ogg', 50)
		return TRUE

	user.NotifyNearby("<span class='danger'>\The [user] fires \the [src]!</span>")
	PlayLocalSound(user, 'sounds/effects/gunfired.ogg', 100)
	firing.ForceMove(get_turf(src))
	firing.ThrownAt(target, user, fire_force)
	return TRUE

/obj/item/gun/AttackedBy(var/mob/user, var/obj/item/prop)
	if(istype(prop, /obj/item/shot))
		if(loading)
			return FALSE
		if(loaded)
			user.Notify("<span class='warning'>\The [src] is already loaded.</span>")
			return FALSE
		loading = TRUE
		user.Notify("<span class='notice'>You begin loading \the [prop] into \the [src].</span>")
		PlayLocalSound(user, 'sounds/effects/click2.ogg', 50)
		if(user.DoAfter(load_time, src, list("loc"), list("loc")))
			user.DropItem(prop)
			loaded = prop
			prop.ForceMove(src)
			user.NotifyNearby("<span class='notice'>\The [user] loads \the [prop] into \the [src].</span>")
			PlayLocalSound(user, 'sounds/effects/gunloaded.ogg', 50)
		loading = FALSE
		return TRUE
	. = ..()