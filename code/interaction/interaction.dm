// Entry point for the click resolution chain.
/client/
	var/list/last_click = list()

/client/Click(object,location,control,params)
	last_click = params2list(params)
	if(world.time > next_click)
		next_click = world.time + 1
		interface.OnClick(object, location, control, params)

/atom/movable/proc/Burn(var/mob/user, var/slot)
	if(temperature >= user.burn_point && user.GetHeatInsulation(slot) < temperature)
		return TRUE
	return FALSE

/atom/proc/ManipulatedBy(var/mob/user, var/slot)
	if(IsOnFire() && user.intent.selecting == INTENT_HELP)
		fire_intensity = max(0, fire_intensity - rand(15,30))
		if(fire_intensity)
			if(prob(5))
				user.Ignite()
			NotifyNearby("<span class='notice'>\The [user] beats at the flaming [src.name]!</span>", MESSAGE_VISIBLE)
			UpdateFireOverlay()
		else
			NotifyNearby("<span class='notice'>\The [user] extinguishes \the [src].</span>", MESSAGE_VISIBLE)
			Extinguish()
		return TRUE
	return FALSE

/atom/proc/AttackedBy(var/mob/user, var/obj/item/prop)
	if(IsFlammable() && prop.IsFlammable())
		if(!prop.IsOnFire() && IsOnFire())
			user.NotifyNearby("<span class='warning'>\The [user] lights \the [prop] in \the [src].</span>", MESSAGE_VISIBLE)
			prop.Ignite(user)
			return TRUE
		else if(prop.IsOnFire() && !IsOnFire())
			user.NotifyNearby("<span class='warning'>\The [user] lights \the [src] with \the [prop].</span>", MESSAGE_VISIBLE)
			Ignite(user)
			return TRUE
	return FALSE
