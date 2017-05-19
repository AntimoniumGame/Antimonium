/atom
	var/on_fire = FALSE

/atom/proc/ignite()
	on_fire = TRUE
	update_icon()

/atom/proc/extinguish()
	on_fire = FALSE
	update_icon()
