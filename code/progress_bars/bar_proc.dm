var/const/do_after_check_period = 5

/mob/proc/do_after(var/delay = 0, var/atom/target, var/list/check_own_vars = list("loc"), var/list/check_target_vars = list("loc"), var/check_incapacitated = TRUE)

	if(target && !istype(target))
		return FALSE

	if(check_incapacitated && Incapacitated())
		return FALSE

	var/initial_target = target

	var/list/last_own_vars
	if(check_own_vars)
		last_own_vars = list()
		for(var/checkvar in check_own_vars)
			last_own_vars[checkvar] = vars[checkvar]

	var/list/last_target_vars
	if(initial_target && check_target_vars)
		last_target_vars = list()
		for(var/checkvar in check_target_vars)
			last_target_vars[checkvar] = target.vars[checkvar]

	var/datum/progress_bar/bar
	if(client)
		bar = new(client, target)
		bar.Start(delay)

	. = TRUE
	while(delay > 0)

		if(check_incapacitated && Incapacitated())
			. = FALSE
			break

		for(var/checkvar in last_own_vars)
			Dnotify("comparing self [checkvar]: [vars[checkvar]] (\ref[vars[checkvar]]) == [last_own_vars[checkvar]] (\ref[last_own_vars[checkvar]])")
			if(vars[checkvar] != last_own_vars[checkvar])
				. = FALSE
				break

		if(!.)
			break

		if(initial_target)
			if(istype(target))
				for(var/checkvar in last_target_vars)
					Dnotify("comparing target [checkvar]: [target.vars[checkvar]] (\ref[target.vars[checkvar]]) == [last_target_vars[checkvar]] (\ref[last_target_vars[checkvar]])")
					if(target.vars[checkvar] != last_target_vars[checkvar])
						. = FALSE
						break
			else
				. = FALSE

		if(!.)
			break

		delay -= do_after_check_period
		sleep(do_after_check_period)

	if(bar)
		QDel(bar)