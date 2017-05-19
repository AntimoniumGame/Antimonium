/atom
	var/on_fire = FALSE

/atom/proc/ignite(var/mob/user)
	on_fire = TRUE
	update_icon()

/atom/proc/extinguish(var/mob/user)
	on_fire = FALSE
	update_icon()
