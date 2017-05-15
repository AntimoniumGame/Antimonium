/proc/check_suspend()
	if(world.tick_usage >= 100)
		sleep(world.tick_lag)

var/datum/master_controller/mc

/datum/master_controller
	var/list/daemons = list()
	var/list/next_daemon_proc = list()

/datum/master_controller/New()

	. = ..()
	if(mc)
		daemons = mc.daemons
		qdel(mc)
		mc = src
	else
		setup()

	start_processing()

/datum/master_controller/destroy()
	daemons.Cut()
	. = ..()

/datum/master_controller/proc/setup()
	for(var/dtype in (typesof(/datum/daemon)-/datum/daemon))
		var/datum/daemon/daemon = get_unique_data_by_path(dtype)
		daemons += daemon
		next_daemon_proc["\ref[daemon]"] = world.time

/datum/master_controller/proc/start_processing()
	set waitfor = 0
	set background = 1
	for(var/datum/daemon/daemon in daemons)
		daemon.start()
